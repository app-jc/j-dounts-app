import 'package:drift/drift.dart';

class Shops extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get photo => text()();
  IntColumn get sortOrder => integer().unique()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
