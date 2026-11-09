import 'package:drift/drift.dart';

class Products extends Table {
  TextColumn get code => text()();
  TextColumn get name => text()();
  IntColumn get priceMmk => integer()();
  BoolColumn get isNew => boolean().withDefault(const Constant(false))();
  TextColumn get discountLabel => text().nullable()();
  TextColumn get description => text()();
  TextColumn get image => text()();

  @override
  Set<Column<Object>> get primaryKey => {code};
}
