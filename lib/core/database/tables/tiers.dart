import 'package:drift/drift.dart';

class Tiers extends Table {
  TextColumn get name => text()();
  IntColumn get threshold => integer().unique()();
  IntColumn get sortOrder => integer().unique()();

  @override
  Set<Column<Object>> get primaryKey => {name};
}
