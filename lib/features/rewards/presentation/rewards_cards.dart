import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/core/images/app_cached_image.dart';
import 'package:j_dounts_app/core/widgets/press_scale.dart';
import 'package:j_dounts_app/features/rewards/domain/challenge_progress.dart';
import 'package:j_dounts_app/features/rewards/domain/rewards_data.dart';
import 'package:j_dounts_app/features/rewards/presentation/rewards_artwork.dart';
import 'package:j_dounts_app/features/rewards/presentation/rewards_entrance.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

class RewardsChallengeEntrance extends StatelessWidget {
  const RewardsChallengeEntrance({
    required this.challenge,
    required this.index,
    required this.entrance,
    super.key,
  });

  final RewardChallenge challenge;
  final int index;
  final RewardsEntrance entrance;

  @override
  Widget build(BuildContext context) {
    final animation = entrance.challenge(index);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Opacity(
        opacity: animation.value,
        child: Transform.translate(
          offset: Offset(0, AppSpacing.md * (1 - animation.value)),
          child: child,
        ),
      ),
      child: RepaintBoundary(
        child: RewardsChallengeCard(
          challenge: challenge,
          entrance: entrance.earn,
          artworkEntrance: entrance.artwork(index),
        ),
      ),
    );
  }
}

class RewardsChallengeCard extends StatelessWidget {
  const RewardsChallengeCard({
    required this.challenge,
    required this.entrance,
    required this.artworkEntrance,
    super.key,
  });

  final RewardChallenge challenge;
  final Animation<double> entrance;
  final Animation<double> artworkEntrance;

  @override
  Widget build(BuildContext context) {
    final complete = challenge.current >= challenge.goal;
    final fraction = ChallengeProgress.fraction(
      challenge.current,
      challenge.goal,
    );
    final localizations = AppLocalizations.of(context);
    return _CardSurface(
      child: Row(
        children: [
          SizedBox.square(
            dimension: AppSpacing.xxl * 2,
            child: RepaintBoundary(
              child: AnimatedBuilder(
                animation: artworkEntrance,
                builder: (context, _) => CustomPaint(
                  painter: ChallengeArtworkPainter(
                    type: challenge.artworkType,
                    progress: fraction * artworkEntrance.value,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  challenge.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${challenge.current.clamp(0, challenge.goal > 0 ? challenge.goal : 0)}/${challenge.goal}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Column(
            children: [
              AnimatedBuilder(
                animation: entrance,
                builder: (context, child) => Transform.scale(
                  scale: complete
                      ? 1 + 0.06 * math.sin(math.pi * entrance.value)
                      : 1,
                  child: child,
                ),
                child: PressScale(
                  onPressed: complete ? () {} : null,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: complete
                          ? AppColors.actionBlue
                          : AppColors.disabledFill,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.pillRadius,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      child: Text(
                        localizations.earn,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                localizations.points(challenge.pointsReward),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RewardsGiftCard extends StatelessWidget {
  const RewardsGiftCard({required this.gift, super.key});

  final RewardGift gift;

  @override
  Widget build(BuildContext context) => _CardSurface(
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.imageClipRadius),
          child: AppCachedImage(
            source: gift.image,
            width: AppSpacing.xxl * 2,
            height: AppSpacing.xxl * 2,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(gift.title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpacing.xs),
              Text(AppLocalizations.of(context).points(gift.pointsCost)),
            ],
          ),
        ),
      ],
    ),
  );
}

class _CardSurface extends StatelessWidget {
  const _CardSurface({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: AppSpacing.md),
    padding: const EdgeInsets.all(AppSpacing.md),
    decoration: BoxDecoration(
      color: AppColors.surfaceCard,
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
    ),
    child: child,
  );
}
