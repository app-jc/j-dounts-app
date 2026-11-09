import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/core/database/app_database.dart';
import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/features/auth/data/fake_auth_repository.dart';
import 'package:j_dounts_app/features/auth/data/local_user_source.dart';
import 'package:j_dounts_app/features/auth/domain/auth_identity.dart';

void main() {
  late AppDatabase database;
  late FakeAuthRepository repository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = FakeAuthRepository(
      LocalUserSource(database),
      latency: Duration.zero,
    );
  });

  tearDown(() async {
    await database.close();
  });

  test('fake authentication latency defaults to one second', () {
    expect(fakeAuthLatency, const Duration(seconds: 1));
  });

  test('requesting an OTP accepts canonical phone numbers only', () async {
    final success = await repository.requestOtp('+95912345678');
    final invalid = await repository.requestOtp('0912345678');

    expect(success, const Success<void>(null));
    expect(invalid, isA<FailureResult<void>>());
  });

  test('unregistered phones receive a generated registration OTP', () async {
    await repository.requestOtp('+95912345678');

    final pending = await repository.pendingOtp('+95912345678');
    final code = _successValue(pending);
    expect(code, matches(RegExp(r'^\d{6}$')));

    expect(
      await repository.verifyRegistrationOtp(
        phone: '+95912345678',
        code: code!,
      ),
      const Success<void>(null),
    );
  });

  test(
    'seeded login OTP remains fixed and is not exposed as registration OTP',
    () async {
      await database
          .into(database.members)
          .insert(
            MembersCompanion.insert(
              phone: '+95912345678',
              firstName: 'Seeded',
              dateOfBirth: DateTime(2000, 1, 1),
            ),
          );

      await repository.requestOtp('+95912345678');

      expect(
        await repository.pendingOtp('+95912345678'),
        const Success<String?>(null),
      );
      expect(
        await repository.verifyOtp(phone: '+95912345678', code: '123456'),
        isA<Success<AuthIdentity>>(),
      );
    },
  );

  test('registration stores member locally and returns its identity', () async {
    final result = await repository.registerMember(
      phone: '+95912345678',
      firstName: '  Charlotte ',
      lastName: ' Bennett ',
      dateOfBirth: DateTime(2010, 6, 6),
    );

    final identity = _successValue(result);
    final member = await (database.select(
      database.members,
    )..where((row) => row.id.equals(identity.memberId))).getSingle();

    expect(identity, isA<AuthIdentity>());
    expect(member.phone, '+95912345678');
    expect(member.firstName, 'Charlotte');
    expect(member.lastName, 'Bennett');
    expect(member.dateOfBirth, DateTime(2010, 6, 6));
    expect(member.totalPoints, 0);
  });

  test(
    'registration converts duplicate phone constraint to typed conflict',
    () async {
      await repository.registerMember(
        phone: '+95912345678',
        firstName: 'Charlotte',
        lastName: null,
        dateOfBirth: DateTime(2010, 6, 6),
      );

      final result = await repository.registerMember(
        phone: '+95912345678',
        firstName: 'Another',
        lastName: null,
        dateOfBirth: DateTime(2000, 1, 1),
      );

      expect(
        result,
        isA<FailureResult<AuthIdentity>>().having(
          (failure) => failure.failure,
          'failure',
          isA<ConflictFailure>().having(
            (failure) => failure.code,
            'code',
            ConflictFailureCode.duplicatePhone,
          ),
        ),
      );
    },
  );

  test('OTP verification requires a registered member and fake code', () async {
    final unregistered = await repository.verifyOtp(
      phone: '+95912345678',
      code: '123456',
    );
    expect(
      unregistered,
      isA<FailureResult<AuthIdentity>>().having(
        (failure) => failure.failure,
        'failure',
        isA<AuthFailure>().having(
          (failure) => failure.code,
          'code',
          AuthFailureCode.notRegistered,
        ),
      ),
    );

    final registration = await repository.registerMember(
      phone: '+95912345678',
      firstName: 'Charlotte',
      lastName: null,
      dateOfBirth: DateTime(2010, 6, 6),
    );
    final memberId = _successValue(registration).memberId;

    final wrongCode = await repository.verifyOtp(
      phone: '+95912345678',
      code: '000000',
    );
    expect(
      wrongCode,
      isA<FailureResult<AuthIdentity>>().having(
        (failure) => failure.failure,
        'failure',
        isA<AuthFailure>().having(
          (failure) => failure.code,
          'code',
          AuthFailureCode.wrongOtp,
        ),
      ),
    );

    final verified = await repository.verifyOtp(
      phone: '+95912345678',
      code: '123456',
    );
    expect(_successValue(verified), AuthIdentity(memberId: memberId));
  });

  test('registration reports whether a member already exists', () async {
    expect(
      _successValue(await repository.isRegistered('+95912345678')),
      isFalse,
    );
    await repository.registerMember(
      phone: '+95912345678',
      firstName: 'Charlotte',
      lastName: null,
      dateOfBirth: DateTime(2010, 6, 6),
    );
    expect(
      _successValue(await repository.isRegistered('+95912345678')),
      isTrue,
    );
  });

  test('rejects registration without complete profile data', () async {
    final result = await repository.registerMember(
      phone: '+95912345678',
      firstName: '',
      lastName: null,
      dateOfBirth: DateTime.now(),
    );

    expect(result, isA<FailureResult<AuthIdentity>>());
    expect(await repository.isRegistered('+95912345678'), const Success(false));
  });

  test('deletes a registered member permanently', () async {
    final registration = await repository.registerMember(
      phone: '+95912345678',
      firstName: 'Charlotte',
      lastName: null,
      dateOfBirth: DateTime(2000, 6, 6),
    );
    final memberId = _successValue(registration).memberId;

    expect(await repository.deleteMember(memberId), const Success<void>(null));
    expect(
      await repository.isRegistered('+95912345678'),
      const Success<bool>(false),
    );
  });
}

T _successValue<T>(Result<T> result) => switch (result) {
  Success<T>(value: final value) => value,
  FailureResult<T>(failure: final failure) => throw StateError(
    'Expected success, received ${failure.type}.',
  ),
};
