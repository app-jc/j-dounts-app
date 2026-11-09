import 'package:drift/drift.dart';

import 'package:j_dounts_app/core/database/tables/challenges.dart';
import 'package:j_dounts_app/core/database/tables/members.dart';

class MemberChallengeProgress extends Table {
  IntColumn get memberId => integer().references(Members, #id)();
  TextColumn get challengeId => text().references(Challenges, #id)();
  IntColumn get current => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {memberId, challengeId};
}
