import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/core/member/presentation/points_to_next.dart';
import 'package:j_dounts_app/features/rewards/domain/tier_calculator.dart';
import 'package:j_dounts_app/features/rewards/presentation/rewards_artwork.dart';
import 'package:j_dounts_app/features/rewards/presentation/rewards_entrance.dart';
import 'package:j_dounts_app/features/rewards/presentation/rewards_state.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

class RewardsSummary extends StatelessWidget {
  const RewardsSummary({
    required this.state,
    required this.entrance,
    super.key,
  });

  final RewardsLoaded state;
  final RewardsEntrance entrance;

  @override
  Widget build(BuildContext context) {
    final progress = state.tierProgress;
    final currentIndex = state.data.tiers.indexOf(progress.currentTier);
    final tiers = currentIndex == 0
        ? state.data.tiers
        : state.data.tiers.skip(1).toList();
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final ringSize = (constraints.maxWidth * 0.48).clamp(120.0, 220.0);
          return Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var index = 0; index < tiers.length; index++)
                      AnimatedBuilder(
                        animation: entrance.tier(index),
                        builder: (context, child) {
                          final value = entrance.tier(index).value;
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, AppSpacing.sm * (1 - value)),
                              child: child,
                            ),
                          );
                        },
                        child: _TierRow(
                          tier: tiers[index],
                          current: tiers[index] == progress.currentTier,
                          next:
                              progress is HasNextTier &&
                              tiers[index] == progress.nextTier,
                          progress: progress,
                          entrance: entrance.ladderFill,
                          last: index == tiers.length - 1,
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                width: ringSize,
                height: ringSize,
                child: AnimatedBuilder(
                  animation: entrance.controller,
                  builder: (context, _) {
                    final fraction = progress.fraction * entrance.ring.value;
                    final total =
                        (state.data.member!.totalPoints * entrance.count.value)
                            .round();
                    return RepaintBoundary(
                      child: CustomPaint(
                        painter: RewardsRingPainter(fraction),
                        child: Center(
                          child: SizedBox(
                            width: ringSize * 0.6,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  AppLocalizations.of(context).totalPoints,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: AppColors.brandPink),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    NumberFormat.decimalPattern(
                                      Localizations.localeOf(context)
                                          .toString(),
                                    ).format(total),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(color: AppColors.brandPink),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TierRow extends StatelessWidget {
  const _TierRow({
    required this.tier,
    required this.current,
    required this.next,
    required this.progress,
    required this.entrance,
    required this.last,
  });

  final TierDefinition tier;
  final bool current;
  final bool next;
  final TierProgress progress;
  final Animation<double> entrance;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final text = current
        ? l10n.youreHereNow
        : next
        ? pointsToNextText(l10n, progress)
        : l10n.youllBeHereSoon;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: AppSpacing.lg,
              backgroundColor: current
                  ? AppColors.ringBlueLight
                  : AppColors.surfaceHome,
              child: Text(
                tier.name.characters.first,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            if (!last)
              SizedBox(
                width: 2,
                height: AppSpacing.lg,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: AppColors.disabledFill,
                  ),
                  child: AnimatedBuilder(
                    animation: entrance,
                    builder: (context, _) => Align(
                      alignment: Alignment.topCenter,
                      child: FractionallySizedBox(
                        heightFactor: current
                            ? progress.fraction * entrance.value
                            : 0,
                        child: const ColoredBox(color: AppColors.actionBlue),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tier.name, style: Theme.of(context).textTheme.titleMedium),
              Text(text, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}

class RewardsBadge extends StatelessWidget {
  const RewardsBadge({required this.count, required this.entrance, super.key});

  final int count;
  final Animation<double> entrance;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: entrance,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.badgeOrange,
          borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Text(
            '${AppLocalizations.of(context).rewards} $count',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}
