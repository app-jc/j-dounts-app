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
    final currentIndex = _currentTierIndex(totalPoints);
    final currentTier = tiers[currentIndex];
    if (currentIndex == tiers.length - 1) {
      return TopTier(currentTier: currentTier);
    }

    final nextTier = tiers[currentIndex + 1];
    final tierSpan = nextTier.threshold - currentTier.threshold;
    final earnedInTier = totalPoints - currentTier.threshold;
    final fraction = (earnedInTier / tierSpan).clamp(0.0, 1.0).toDouble();
    return HasNextTier(
      currentTier: currentTier,
      nextTier: nextTier,
      remaining: nextTier.threshold - totalPoints,
      fraction: fraction,
    );
  }

  int _currentTierIndex(int totalPoints) {
    var index = 0;
    for (var candidate = 1; candidate < tiers.length; candidate++) {
      if (totalPoints < tiers[candidate].threshold) break;
      index = candidate;
    }
    return index;
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
