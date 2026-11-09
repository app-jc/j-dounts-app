import 'package:drift/drift.dart';

class Sections extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get type => text()();
  TextColumn get layoutStyle => text()();
  IntColumn get sortOrder => integer().unique()();
  BoolColumn get seeAll => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
