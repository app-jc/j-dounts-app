import 'package:equatable/equatable.dart';

import 'package:j_dounts_app/core/member/domain/member.dart';
import 'package:j_dounts_app/features/rewards/domain/tier_calculator.dart';

final class RewardsData extends Equatable {
  RewardsData({
    required this.member,
    required List<TierDefinition> tiers,
    required List<RewardChallenge> challenges,
    required List<RewardGift> gifts,
  }) : tiers = List.unmodifiable(tiers),
       challenges = List.unmodifiable(challenges),
       gifts = List.unmodifiable(gifts);

  final Member? member;
  final List<TierDefinition> tiers;
  final List<RewardChallenge> challenges;
  final List<RewardGift> gifts;

  @override
  List<Object?> get props => [member, tiers, challenges, gifts];
}

final class RewardChallenge extends Equatable {
  const RewardChallenge({
    required this.id,
    required this.title,
    required this.goal,
    required this.pointsReward,
    required this.artworkType,
    required this.sortOrder,
    required this.current,
  });

  final String id;
  final String title;
  final int goal;
  final int pointsReward;
  final String artworkType;
  final int sortOrder;
  final int current;

  @override
  List<Object?> get props => [
    id,
    title,
    goal,
    pointsReward,
    artworkType,
    sortOrder,
    current,
  ];
}

final class RewardGift extends Equatable {
  const RewardGift({
    required this.id,
    required this.title,
    required this.pointsCost,
    required this.image,
    required this.sortOrder,
  });

  final String id;
  final String title;
  final int pointsCost;
  final String image;
  final int sortOrder;

  @override
  List<Object?> get props => [id, title, pointsCost, image, sortOrder];
}
