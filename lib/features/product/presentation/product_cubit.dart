import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/features/product/domain/product.dart';
import 'package:j_dounts_app/features/product/domain/product_quantity.dart';
import 'package:j_dounts_app/features/product/domain/product_repository.dart';

enum ProductStatus { loading, loaded, notFound, failure }

final class ProductState extends Equatable {
  const ProductState({
    this.status = ProductStatus.loading,
    this.product,
    this.failure,
    this.quantity = ProductQuantity.min,
    this.addedToCart = false,
  });

  final ProductStatus status;
  final Product? product;
  final Failure? failure;
  final int quantity;
  final bool addedToCart;

  int get totalMmk => (product?.priceMmk ?? 0) * quantity;

  ProductState copyWith({
    ProductStatus? status,
    Product? product,
    Failure? failure,
    int? quantity,
    bool? addedToCart,
  }) => ProductState(
    status: status ?? this.status,
    product: product ?? this.product,
    failure: failure ?? this.failure,
    quantity: quantity ?? this.quantity,
    addedToCart: addedToCart ?? this.addedToCart,
  );

  @override
  List<Object?> get props => [status, product, failure, quantity, addedToCart];
}

final class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._repository, {required String code})
    : code = code,
      super(const ProductState()) {
    _subscription = _repository.watchByCode(code).listen(_onResult);
  }

  final ProductRepository _repository;
  final String code;
  late final StreamSubscription<Result<Product?>> _subscription;

  void increment() => _setQuantity(state.quantity + 1);

  void decrement() => _setQuantity(state.quantity - 1);

  void addToCart() {
    if (state.status != ProductStatus.loaded || state.addedToCart) return;
    emit(state.copyWith(addedToCart: true));
  }

  void clearCartFeedback() {
    if (!state.addedToCart) return;
    emit(state.copyWith(addedToCart: false));
  }

  void _setQuantity(int quantity) {
    if (state.status != ProductStatus.loaded) return;
    final next = quantity.clamp(ProductQuantity.min, ProductQuantity.max);
    if (next == state.quantity) return;
    emit(state.copyWith(quantity: next));
  }

  void _onResult(Result<Product?> result) {
    result.fold(onSuccess: _onProduct, onFailure: _onFailure);
  }

  void _onProduct(Product? product) {
    if (product == null) {
      emit(
        ProductState(status: ProductStatus.notFound, quantity: state.quantity),
      );
      return;
    }
    emit(
      ProductState(
        status: ProductStatus.loaded,
        product: product,
        quantity: state.quantity,
        addedToCart: state.addedToCart,
      ),
    );
  }

  void _onFailure(Failure failure) {
    emit(
      ProductState(
        status: ProductStatus.failure,
        failure: failure,
        quantity: state.quantity,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
