import 'package:drift/drift.dart';

class Challenges extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  IntColumn get goal => integer()();
  IntColumn get pointsReward => integer()();
  TextColumn get artworkType => text()();
  IntColumn get sortOrder => integer().unique()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
