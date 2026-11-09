import 'package:drift/drift.dart';

class Banners extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get image => text()();
  IntColumn get sortOrder => integer().unique()();
  TextColumn get target => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
