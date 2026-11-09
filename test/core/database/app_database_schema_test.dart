import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/core/database/app_database.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test('member phone numbers are unique', () async {
    final firstMember = MembersCompanion.insert(
      phone: '+95912345678',
      firstName: 'Charlotte',
      dateOfBirth: DateTime(2010, 6, 6),
    );
    await database.into(database.members).insert(firstMember);

    final duplicatePhone = MembersCompanion.insert(
      phone: '+95912345678',
      firstName: 'Another',
      dateOfBirth: DateTime(2000, 1, 1),
    );

    await expectLater(
      database.into(database.members).insert(duplicatePhone),
      throwsA(isA<Exception>()),
    );
  });

  test('seed flag defaults to false and can be marked complete', () async {
    expect(await database.hasSeeded, isFalse);

    await database.markSeeded();

    expect(await database.hasSeeded, isTrue);
  });
}
