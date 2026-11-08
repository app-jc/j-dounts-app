import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/core/utils/formatters.dart';

void main() {
  group('formatMmk', () {
    test('formats zero with the MMK suffix', () {
      expect(formatMmk(0), '0 MMK');
    });

    test('groups thousands with commas', () {
      expect(formatMmk(3200), '3,200 MMK');
      expect(formatMmk(123456789), '123,456,789 MMK');
    });

    test('preserves the sign of negative amounts', () {
      expect(formatMmk(-3200), '-3,200 MMK');
    });
  });
}
