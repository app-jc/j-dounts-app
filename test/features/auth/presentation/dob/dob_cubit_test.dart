import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/core/database/app_database.dart';
import 'package:j_dounts_app/core/time/clock.dart';
import 'package:j_dounts_app/features/auth/data/fake_auth_repository.dart';
import 'package:j_dounts_app/features/auth/data/local_user_source.dart';
import 'package:j_dounts_app/features/auth/presentation/dob/dob_cubit.dart';

final class _FixedClock implements Clock {
  const _FixedClock(this.value);

  final DateTime value;

  @override
  DateTime now() => value;
}

void main() {
  late AppDatabase database;
  late DobCubit cubit;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    cubit = DobCubit(
      FakeAuthRepository(LocalUserSource(database), latency: Duration.zero),
      phone: '+95912345678',
      firstName: 'Aung',
      lastName: null,
      clock: _FixedClock(DateTime(2026, 6, 15)),
    );
  });

  tearDown(() async {
    await cubit.close();
    await database.close();
  });

  test(
    'rejects an invalid date and accepts a valid registration date',
    () async {
      cubit.select(year: 2000, month: 4, day: 31);
      expect(await cubit.submit(), isNull);
      expect(cubit.state.failure, isNotNull);

      cubit.select(year: 2000, month: 5, day: 1);
      expect((await cubit.submit())?.memberId, isPositive);
      expect(cubit.state.status, DobStatus.submitted);
    },
  );
}
