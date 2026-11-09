import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/core/database/app_database.dart';
import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/core/time/clock.dart';
import 'package:j_dounts_app/features/auth/data/fake_auth_repository.dart';
import 'package:j_dounts_app/features/auth/data/local_user_source.dart';
import 'package:j_dounts_app/features/auth/presentation/otp/otp_cubit.dart';

final class _FakeClock implements Clock {
  _FakeClock(this.value);

  DateTime value;

  @override
  DateTime now() => value;
}

void main() {
  late AppDatabase database;
  late OtpCubit cubit;
  late _FakeClock clock;

  setUp(() async {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    await database
        .into(database.members)
        .insert(
          MembersCompanion.insert(
            phone: '+95912345678',
            firstName: 'Test',
            dateOfBirth: DateTime(2000, 1, 1),
          ),
        );
    clock = _FakeClock(DateTime(2026, 1, 1));
    cubit = OtpCubit(
      FakeAuthRepository(LocalUserSource(database), latency: Duration.zero),
      phone: '+95912345678',
      clock: clock,
    );
  });

  tearDown(() async {
    await cubit.close();
    await database.close();
  });

  test(
    'wrong codes clear input, shake, and lock after three attempts',
    () async {
      for (var attempt = 1; attempt <= 3; attempt++) {
        cubit.updateCode('000000');
        await cubit.verify();
        expect(cubit.state.code, isEmpty);
        expect(cubit.state.shakeToken, attempt);
      }

      expect(cubit.state.isLocked, isTrue);
      expect(cubit.state.failure, isA<AuthFailure>());
    },
  );

  test('correct code emits verified identity', () async {
    cubit.updateCode('123456');

    await cubit.verify();

    expect(cubit.state.status, OtpStatus.verified);
    expect(cubit.state.identity?.memberId, isPositive);
  });

  test('resend is enabled after the deadline and resets attempts', () async {
    cubit.updateCode('000000');
    await cubit.verify();
    clock.value = clock.value.add(const Duration(minutes: 5));

    await cubit.resend();

    expect(cubit.state.status, OtpStatus.idle);
    expect(cubit.state.attempt.wrongAttempts, 0);
    expect(cubit.state.remaining, const Duration(minutes: 5));
  });

  test('registration OTP auto-fills and verifies the pending code', () async {
    final phone = '+95998765432';
    final repository = FakeAuthRepository(
      LocalUserSource(database),
      latency: Duration.zero,
    );
    await repository.requestOtp(phone);
    await cubit.close();
    cubit = OtpCubit(
      repository,
      phone: phone,
      isRegistration: true,
      clock: clock,
    );

    await Future<void>.delayed(const Duration(milliseconds: 350));

    expect(cubit.state.status, OtpStatus.verified);
  });

  test('closing registration OTP cancels auto-fill', () async {
    final phone = '+95998765432';
    final repository = FakeAuthRepository(
      LocalUserSource(database),
      latency: Duration.zero,
    );
    await repository.requestOtp(phone);
    await cubit.close();
    cubit = OtpCubit(
      repository,
      phone: phone,
      isRegistration: true,
      clock: clock,
    );

    await cubit.close();
    await Future<void>.delayed(const Duration(milliseconds: 350));

    expect(cubit.isClosed, isTrue);
  });
}
