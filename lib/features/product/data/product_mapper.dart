import 'package:j_dounts_app/core/database/app_database.dart' as database;
import 'package:j_dounts_app/features/product/domain/product.dart' as domain;

abstract final class ProductMapper {
  static domain.Product fromRow(database.Product row) => domain.Product(
    code: row.code,
    name: row.name,
    priceMmk: row.priceMmk,
    isNew: row.isNew,
    discountLabel: row.discountLabel,
    description: row.description,
    image: row.image,
  );
}
