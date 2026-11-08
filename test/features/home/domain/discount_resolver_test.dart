import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/features/home/domain/discount_resolver.dart';

void main() {
  group('resolveDiscountLabel', () {
    test('uses the section override when present', () {
      expect(
        resolveDiscountLabel(
          productDiscount: '10% OFF',
          sectionOverride: '20% OFF',
        ),
        '20% OFF',
      );
    });

    test('falls back to the product discount without an override', () {
      expect(resolveDiscountLabel(productDiscount: '10% OFF'), '10% OFF');
    });

    test('returns null when neither source has a discount', () {
      expect(resolveDiscountLabel(productDiscount: null), isNull);
    });
  });
}
