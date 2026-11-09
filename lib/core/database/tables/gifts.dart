import 'package:drift/drift.dart';

class Gifts extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  IntColumn get pointsCost => integer()();
  TextColumn get image => text()();
  IntColumn get sortOrder => integer().unique()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
