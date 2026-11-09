import 'package:drift/drift.dart';

import 'package:j_dounts_app/core/database/tables/products.dart';
import 'package:j_dounts_app/core/database/tables/sections.dart';

class SectionProducts extends Table {
  TextColumn get sectionId => text().references(Sections, #id)();
  TextColumn get productCode => text().references(Products, #code)();
  IntColumn get sortOrder => integer()();
  TextColumn get discountOverride => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {sectionId, productCode};
}
