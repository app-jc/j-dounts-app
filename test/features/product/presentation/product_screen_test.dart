import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/features/product/domain/product.dart';
import 'package:j_dounts_app/features/product/domain/product_repository.dart';
import 'package:j_dounts_app/features/product/presentation/product_cubit.dart';
import 'package:j_dounts_app/features/product/presentation/product_screen.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

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

  testWidgets('shows New badge, live total, and add-to-cart feedback', (
    tester,
  ) async {
    controller.add(const Success(_coconut));
    await pumpEventQueue();
    await tester.pumpWidget(_app(cubit));

    expect(find.text('New'), findsOneWidget);
    expect(find.text('3,200 MMK'), findsAtLeastNWidgets(1));
    expect(find.textContaining('ADD TO CART'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    await tester.tap(find.textContaining('ADD TO CART'));
    await tester.pump();

    expect(cubit.state.quantity, 2);
    expect(find.textContaining('6,400 MMK'), findsOneWidget);
    expect(cubit.state.addedToCart, isTrue);
    expect(find.text('ADDED TO CART'), findsOneWidget);
  });

  testWidgets('shows a not-found state for a missing product', (tester) async {
    controller.add(const Success(null));
    await pumpEventQueue();
    await tester.pumpWidget(_app(cubit));

    expect(find.textContaining('Product not found'), findsOneWidget);
  });
}

Widget _app(ProductCubit cubit) {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: BlocProvider.value(
      value: cubit,
      child: ProductScreen(code: cubit.code),
    ),
  );
}

final class _FakeProductRepository implements ProductRepository {
  _FakeProductRepository(this._stream);

  final Stream<Result<Product?>> _stream;

  @override
  Stream<Result<Product?>> watchByCode(String code) => _stream;
}
