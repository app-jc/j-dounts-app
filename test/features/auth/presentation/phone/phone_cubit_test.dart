import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/core/database/app_database.dart';
import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/features/auth/data/fake_auth_repository.dart';
import 'package:j_dounts_app/features/auth/data/local_user_source.dart';
import 'package:j_dounts_app/features/auth/presentation/flow/auth_flow_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/phone/phone_cubit.dart';

void main() {
  late AppDatabase database;
  late PhoneCubit cubit;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    cubit = PhoneCubit(
      FakeAuthRepository(LocalUserSource(database), latency: Duration.zero),
    );
  });

  tearDown(() async {
    await cubit.close();
    await database.close();
  });

  test('invalid input is disabled and reports a blur validation failure', () {
    cubit.updatePhone('09 123');

    expect(cubit.state.isValid, isFalse);
    cubit.markBlurred();

    expect(cubit.state.hasBlurred, isTrue);
    expect(cubit.state.failure, isA<ValidationFailure>());
  });

  test('login rejects an unregistered number', () async {
    cubit.updatePhone('09 12345678');

    await cubit.submit(AuthFlowType.login);

    expect(cubit.state.failure, isA<AuthFailure>());
    expect(
      (cubit.state.failure! as AuthFailure).code,
      AuthFailureCode.notRegistered,
    );
  });

  test('registration rejects an existing number', () async {
    await database
        .into(database.members)
        .insert(
          MembersCompanion.insert(
            phone: '+95912345678',
            firstName: 'Existing',
            dateOfBirth: DateTime(2000, 1, 1),
          ),
        );
    cubit.updatePhone('09 12345678');

    await cubit.submit(AuthFlowType.registration);

    expect(cubit.state.failure, isA<ConflictFailure>());
    expect(
      (cubit.state.failure! as ConflictFailure).code,
      ConflictFailureCode.duplicatePhone,
    );
  });

  test('canonicalizes a valid phone and submits an OTP request', () async {
    cubit.updatePhone('09-1234 5678');

    await cubit.submit(AuthFlowType.registration);

    expect(cubit.state.status, PhoneStatus.submitted);
    expect(cubit.state.phone, '+95912345678');
  });
}
