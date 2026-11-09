import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/features/product/domain/product.dart';

abstract interface class ProductRepository {
  Stream<Result<Product?>> watchByCode(String code);
}
