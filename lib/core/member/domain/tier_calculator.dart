import 'package:equatable/equatable.dart';

final class TierDefinition extends Equatable {
  const TierDefinition({required this.name, required this.threshold});
  final String name;
  final int threshold;
  @override
  List<Object?> get props => [name, threshold];
}

sealed class TierProgress extends Equatable {
  const TierProgress();
  TierDefinition get currentTier;
  double get fraction;
}

final class HasNextTier extends TierProgress {
  const HasNextTier({
    required this.currentTier,
    required this.nextTier,
    required this.remaining,
    required this.fraction,
  });
  @override
  final TierDefinition currentTier;
  final TierDefinition nextTier;
  final int remaining;
  @override
  final double fraction;
  @override
  List<Object?> get props => [currentTier, nextTier, remaining, fraction];
}

final class TopTier extends TierProgress {
  const TopTier({required this.currentTier});
  @override
  final TierDefinition currentTier;
  @override
  double get fraction => 1;
  @override
  List<Object?> get props => [currentTier, fraction];
}

final class TierCalculator {
  TierCalculator(Iterable<TierDefinition> tiers)
    : tiers = List.unmodifiable(tiers) {
    _validateThresholds();
  }
  final List<TierDefinition> tiers;

  TierProgress calculate(int totalPoints) {
    var index = 0;
    for (var candidate = 1; candidate < tiers.length; candidate++) {
      if (totalPoints < tiers[candidate].threshold) break;
      index = candidate;
    }
    final current = tiers[index];
    if (index == tiers.length - 1) return TopTier(currentTier: current);
    final next = tiers[index + 1];
    return HasNextTier(
      currentTier: current,
      nextTier: next,
      remaining: next.threshold - totalPoints,
      fraction:
          ((totalPoints - current.threshold) /
                  (next.threshold - current.threshold))
              .clamp(0.0, 1.0)
              .toDouble(),
    );
  }

  void _validateThresholds() {
    if (tiers.isEmpty) {
      throw ArgumentError.value(tiers, 'tiers', 'Must not be empty.');
    }
    for (var index = 1; index < tiers.length; index++) {
      if (tiers[index].threshold <= tiers[index - 1].threshold) {
        throw ArgumentError.value(
          tiers,
          'tiers',
          'Thresholds must be strictly increasing.',
        );
      }
    }
  }
}
