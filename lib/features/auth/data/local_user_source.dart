import 'package:drift/drift.dart';

import 'package:j_dounts_app/core/database/app_database.dart';

/// A local data source for managing user data in the app's database.
final class LocalUserSource {
  LocalUserSource(this._database);

  final AppDatabase _database;

  /// Checks if a member with the given ID exists in the database.
  Future<bool> memberExists(int memberId) async {
    final query = _database.select(_database.members)
      ..where((member) => member.id.equals(memberId));
    return await query.getSingleOrNull() != null;
  }

  /// Finds the member ID associated with the given phone number.
  /// Returns `null` if no member is found.
  Future<int?> findMemberIdByPhone(String phone) async {
    final query = _database.select(_database.members)
      ..where((member) => member.phone.equals(phone));
    final member = await query.getSingleOrNull();
    return member?.id;
  }

  /// Creates a new member in the database with the provided details.
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

  /// Deletes a member from the database.
  /// This will also delete all related data for the member, including challenge progress and the member record itself.
  Future<void> deleteMember(int memberId) => _database.transaction(() async {
    await (_database.delete(
      _database.memberChallengeProgress,
    )..where((progress) => progress.memberId.equals(memberId))).go();
    await (_database.delete(
      _database.members,
    )..where((member) => member.id.equals(memberId))).go();
  });
}
