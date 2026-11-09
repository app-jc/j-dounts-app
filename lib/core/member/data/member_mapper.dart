import 'package:j_dounts_app/core/database/app_database.dart' as database;
import 'package:j_dounts_app/core/member/domain/member.dart' as domain;

abstract final class MemberMapper {
  static domain.Member fromRow(database.Member row) => domain.Member(
    id: row.id,
    phone: row.phone,
    firstName: row.firstName,
    lastName: row.lastName,
    dateOfBirth: row.dateOfBirth,
    photo: row.photo,
    totalPoints: row.totalPoints,
    notificationCount: row.notificationCount,
  );
}
