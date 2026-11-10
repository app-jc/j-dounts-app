import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/features/rewards/domain/tier_calculator.dart';

TierCalculator _calculator() => TierCalculator([
  const TierDefinition(name: 'Bronze', threshold: 0),
  const TierDefinition(name: 'Silver', threshold: 679000),
  const TierDefinition(name: 'Gold', threshold: 680500),
  const TierDefinition(name: 'Platinum', threshold: 700000),
]);

void main() {
  group('TierCalculator', () {
    test('starts at zero points with no in-tier progress', () {
      expect(
        _calculator().calculate(0),
        const HasNextTier(
          currentTier: TierDefinition(name: 'Bronze', threshold: 0),
          nextTier: TierDefinition(name: 'Silver', threshold: 679000),
          remaining: 679000,
          fraction: 0,
        ),
      );
    });

    test('moves into a tier exactly at its threshold', () {
      expect(
        _calculator().calculate(679000),
        const HasNextTier(
          currentTier: TierDefinition(name: 'Silver', threshold: 679000),
          nextTier: TierDefinition(name: 'Gold', threshold: 680500),
          remaining: 1500,
          fraction: 0,
        ),
      );
    });

    test('reports one point remaining just below a threshold', () {
      final result = _calculator().calculate(678999);
      expect(result, isA<HasNextTier>());
      expect(result.currentTier.name, 'Bronze');
      expect(result.fraction, closeTo(678999 / 679000, 0.0000001));
      if (result case final HasNextTier progress) {
        expect(progress.remaining, 1);
      }
    });

    test('clamps the in-tier fraction below the first threshold', () {
      final result = _calculator().calculate(-1);
      expect(result, isA<HasNextTier>());
      expect(result.fraction, 0);
    });

    test('transitions at every seeded tier boundary', () {
      for (final (points, tier) in [
        (679000, 'Silver'),
        (680500, 'Gold'),
        (700000, 'Platinum'),
      ]) {
        expect(_calculator().calculate(points).currentTier.name, tier);
      }
      final top = _calculator().calculate(700000);
      expect(top, isA<TopTier>());
      expect(top.fraction, 1);
    });

    test('returns top tier with full progress for a very large total', () {
      final result = _calculator().calculate(9000000000);

      expect(result, isA<TopTier>());
      expect(result.currentTier.name, 'Platinum');
      expect(result.fraction, 1);
    });

    test('rejects empty or non-increasing thresholds', () {
      expect(() => TierCalculator([]), throwsArgumentError);
      expect(
        () => TierCalculator([
          const TierDefinition(name: 'Bronze', threshold: 0),
          const TierDefinition(name: 'Silver', threshold: 0),
        ]),
        throwsArgumentError,
      );
      expect(
        () => TierCalculator([
          const TierDefinition(name: 'Silver', threshold: 10),
          const TierDefinition(name: 'Bronze', threshold: 0),
        ]),
        throwsArgumentError,
      );
    });
  });
}
