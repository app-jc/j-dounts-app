import 'package:drift/drift.dart';

import 'package:j_dounts_app/core/database/app_database.dart' as database;
import 'package:j_dounts_app/features/home/domain/home_data.dart' as domain;

abstract final class HomeMapper {
  static domain.HomeBanner banner(database.Banner row) => domain.HomeBanner(
    id: row.id,
    title: row.title,
    image: row.image,
    target: row.target,
    sortOrder: row.sortOrder,
  );

  static domain.HomeShop shop(database.Shop row) => domain.HomeShop(
    id: row.id,
    name: row.name,
    photo: row.photo,
    sortOrder: row.sortOrder,
  );

  static List<domain.HomeSection> sections(
    database.AppDatabase db,
    List<TypedResult> rows,
  ) {
    final grouped = <String, _HomeSectionBuilder>{};
    for (final row in rows) {
      final section = row.readTable(db.sections);
      final builder = grouped.putIfAbsent(
        section.id,
        () => _HomeSectionBuilder(
          id: section.id,
          title: section.title,
          type: section.type,
          layoutStyle: section.layoutStyle,
          sortOrder: section.sortOrder,
          seeAll: section.seeAll,
        ),
      );
      final sectionProduct = row.readTableOrNull(db.sectionProducts);
      final product = row.readTableOrNull(db.products);
      if (sectionProduct != null && product != null) {
        builder.products.add(
          domain.HomeProduct(
            code: product.code,
            name: product.name,
            priceMmk: product.priceMmk,
            isNew: product.isNew,
            discountLabel: product.discountLabel,
            discountOverride: sectionProduct.discountOverride,
            description: product.description,
            image: product.image,
            sortOrder: sectionProduct.sortOrder,
          ),
        );
      }
    }

    return grouped.values.map((section) => section.build()).toList();
  }
}

final class _HomeSectionBuilder {
  _HomeSectionBuilder({
    required this.id,
    required this.title,
    required this.type,
    required this.layoutStyle,
    required this.sortOrder,
    required this.seeAll,
  });

  final String id;
  final String title;
  final String type;
  final String layoutStyle;
  final int sortOrder;
  final bool seeAll;
  final List<domain.HomeProduct> products = [];

  domain.HomeSection build() => domain.HomeSection(
    id: id,
    title: title,
    type: type,
    layoutStyle: layoutStyle,
    sortOrder: sortOrder,
    seeAll: seeAll,
    products: List.unmodifiable(products),
  );
}
