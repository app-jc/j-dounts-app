import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/features/product/domain/product.dart';
import 'package:j_dounts_app/features/product/domain/product_quantity.dart';
import 'package:j_dounts_app/features/product/domain/product_repository.dart';
import 'package:j_dounts_app/features/product/presentation/product_cubit.dart';

const _coconut = Product(
  code: 'JD022123',
  name: 'Coconut Donut',
  priceMmk: 3200,
  isNew: true,
  discountLabel: null,
  description: 'Toasted coconut donut.',
  image: 'asset:assets/images/placeholders/image_fallback.png',
);

void main() {
  late StreamController<Result<Product?>> controller;
  late ProductCubit cubit;

  setUp(() {
    controller = StreamController<Result<Product?>>.broadcast();
    cubit = ProductCubit(
      _FakeProductRepository(controller.stream),
      code: _coconut.code,
    );
  });

  tearDown(() async {
    await cubit.close();
    await controller.close();
  });

  test('loads a product and derives the live list-price total', () async {
    controller.add(const Success(_coconut));
    await pumpEventQueue();

    expect(cubit.state.status, ProductStatus.loaded);
    expect(cubit.state.product?.isNew, isTrue);
    expect(cubit.state.quantity, ProductQuantity.min);
    expect(cubit.state.totalMmk, 3200);

    cubit.increment();
    expect(cubit.state.totalMmk, 6400);
  });

  test('clamps quantity to the named min and max', () async {
    controller.add(const Success(_coconut));
    await pumpEventQueue();

    cubit.decrement();
    expect(cubit.state.quantity, ProductQuantity.min);

    for (var i = 0; i < ProductQuantity.max + 5; i++) {
      cubit.increment();
    }
    expect(cubit.state.quantity, ProductQuantity.max);
  });

  test('add to cart is visual feedback only', () async {
    controller.add(const Success(_coconut));
    await pumpEventQueue();

    cubit.addToCart();
    cubit.addToCart();

    expect(cubit.state.addedToCart, isTrue);
    expect(cubit.state.quantity, ProductQuantity.min);
    expect(cubit.state.product, _coconut);

    cubit.clearCartFeedback();
    expect(cubit.state.addedToCart, isFalse);
  });

  test('emits a not-found state when the product is missing', () async {
    controller.add(const Success(null));
    await pumpEventQueue();

    expect(cubit.state.status, ProductStatus.notFound);
    expect(cubit.state.product, isNull);
  });
}

final class _FakeProductRepository implements ProductRepository {
  _FakeProductRepository(this._stream);

  final Stream<Result<Product?>> _stream;

  @override
  Stream<Result<Product?>> watchByCode(String code) => _stream;
}
