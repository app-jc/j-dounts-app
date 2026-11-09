import 'package:j_dounts_app/core/database/app_database.dart' as database;
import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/core/error/stream_result.dart';
import 'package:j_dounts_app/features/product/data/product_mapper.dart';
import 'package:j_dounts_app/features/product/domain/product.dart';
import 'package:j_dounts_app/features/product/domain/product_repository.dart';

final class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._database);

  final database.AppDatabase _database;

  @override
  Stream<Result<Product?>> watchByCode(String code) {
    final query = _database.select(_database.products)
      ..where((product) => product.code.equals(code));
    return toResultStream(
      query.watchSingleOrNull().map(
        (row) => row == null ? null : ProductMapper.fromRow(row),
      ),
    );
  }
}
