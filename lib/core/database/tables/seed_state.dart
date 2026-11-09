import 'package:drift/drift.dart';

class SeedStates extends Table {
  IntColumn get id => integer()();
  BoolColumn get isSeeded => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
