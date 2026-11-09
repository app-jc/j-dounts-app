import 'package:j_dounts_app/core/database/app_database.dart' as database;
import 'package:j_dounts_app/core/member/domain/member.dart' as member_domain;
import 'package:j_dounts_app/features/rewards/domain/rewards_data.dart'
    as domain;
import 'package:j_dounts_app/features/rewards/domain/tier_calculator.dart';

abstract final class RewardsMapper {
  static domain.RewardsData map({
    required member_domain.Member? member,
    required List<database.Tier> tiers,
    required List<database.Challenge> challenges,
    required List<database.MemberChallengeProgressData> progress,
    required List<database.Gift> gifts,
  }) {
    final progressByChallenge = {
      for (final row in progress) row.challengeId: row.current,
    };
    final orderedTiers = [...tiers]
      ..sort((first, second) => first.sortOrder.compareTo(second.sortOrder));
    final orderedChallenges = [...challenges]
      ..sort((first, second) => first.sortOrder.compareTo(second.sortOrder));
    final orderedGifts = [...gifts]
      ..sort((first, second) => first.sortOrder.compareTo(second.sortOrder));

    return domain.RewardsData(
      member: member,
      tiers: orderedTiers
          .map(
            (tier) =>
                TierDefinition(name: tier.name, threshold: tier.threshold),
          )
          .toList(growable: false),
      challenges: orderedChallenges
          .map(
            (challenge) => domain.RewardChallenge(
              id: challenge.id,
              title: challenge.title,
              goal: challenge.goal,
              pointsReward: challenge.pointsReward,
              artworkType: challenge.artworkType,
              sortOrder: challenge.sortOrder,
              current: progressByChallenge[challenge.id] ?? 0,
            ),
          )
          .toList(growable: false),
      gifts: orderedGifts
          .map(
            (gift) => domain.RewardGift(
              id: gift.id,
              title: gift.title,
              pointsCost: gift.pointsCost,
              image: gift.image,
              sortOrder: gift.sortOrder,
            ),
          )
          .toList(growable: false),
    );
  }
}
