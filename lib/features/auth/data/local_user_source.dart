import 'package:drift/drift.dart';

import 'package:j_dounts_app/core/database/app_database.dart';

final class LocalUserSource {
  LocalUserSource(this._database);

  final AppDatabase _database;

  Future<bool> memberExists(int memberId) async {
    final query = _database.select(_database.members)
      ..where((member) => member.id.equals(memberId));
    return await query.getSingleOrNull() != null;
  }

  Future<int?> findMemberIdByPhone(String phone) async {
    final query = _database.select(_database.members)
      ..where((member) => member.phone.equals(phone));
    final member = await query.getSingleOrNull();
    return member?.id;
  }

  Future<int> createMember({
    required String phone,
    required String firstName,
    required String? lastName,
    required DateTime dateOfBirth,
  }) => _database
      .into(_database.members)
      .insert(
        MembersCompanion.insert(
          phone: phone,
          firstName: firstName,
          lastName: Value(lastName),
          dateOfBirth: dateOfBirth,
        ),
      );

  Future<void> deleteMember(int memberId) => _database.transaction(() async {
    await (_database.delete(
      _database.memberChallengeProgress,
    )..where((progress) => progress.memberId.equals(memberId))).go();
    await (_database.delete(
      _database.members,
    )..where((member) => member.id.equals(memberId))).go();
  });
}
