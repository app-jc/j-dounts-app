import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/core/images/app_cached_image.dart';

const String _fallbackAsset = AppCachedImage.fallbackAsset;
const String _productAsset = 'assets/images/products/coconut_flake_donut.jpg';
const String _networkUrl = 'https://example.invalid/donut.jpg';
const Key _builderKey = ValueKey<String>('image-test-context');

void main() {
  testWidgets('asset sources load directly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: AppCachedImage(source: 'asset:$_productAsset')),
    );
    await tester.pumpAndSettle();

    expect(_findAssetImage(_productAsset), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('https sources configure cache and bundled loading placeholder', (
    tester,
  ) async {
    final widget = await _buildWithoutMountingImage(tester, _networkUrl);
    final cachedImage = widget as CachedNetworkImage;
    final context = tester.element(find.byKey(_builderKey));

    expect(cachedImage.imageUrl, _networkUrl);
    final placeholder = cachedImage.placeholder!(context, _networkUrl);
    expect(_assetPath(placeholder), _fallbackAsset);
  });

  testWidgets('https failures show the bundled fallback image', (tester) async {
    final widget = await _buildWithoutMountingImage(tester, _networkUrl);
    final cachedImage = widget as CachedNetworkImage;
    final context = tester.element(find.byKey(_builderKey));

    final errorWidget = cachedImage.errorWidget!(
      context,
      _networkUrl,
      Exception('test image failure'),
    );

    expect(_assetPath(errorWidget), _fallbackAsset);
  });

  testWidgets('broken asset sources fall back to the bundled image', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AppCachedImage(source: 'asset:assets/images/missing.png'),
      ),
    );
    await tester.pumpAndSettle();

    expect(_findAssetImage(_fallbackAsset), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('empty and unsupported sources use the fallback', (tester) async {
    for (final source in ['', 'ftp://example.invalid/donut.jpg']) {
      final widget = await _buildWithoutMountingImage(tester, source);
      expect(_assetPath(widget), _fallbackAsset);
    }
  });
}

Future<Widget> _buildWithoutMountingImage(
  WidgetTester tester,
  String source,
) async {
  late Widget image;
  await tester.pumpWidget(
    MaterialApp(
      home: Builder(
        key: _builderKey,
        builder: (context) {
          image = AppCachedImage(source: source).build(context);
          return const SizedBox.shrink();
        },
      ),
    ),
  );
  return image;
}

String? _assetPath(Widget widget) {
  if (widget is! Image || widget.image is! AssetImage) return null;
  return (widget.image as AssetImage).assetName;
}

Finder _findAssetImage(String path) =>
    find.byWidgetPredicate((widget) => _assetPath(widget) == path);
