import 'package:equatable/equatable.dart';

import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/features/rewards/domain/rewards_data.dart';
import 'package:j_dounts_app/features/rewards/domain/tier_calculator.dart';

sealed class RewardsState extends Equatable {
  const RewardsState();
}

enum RewardsTab { challenges, gifts }

final class RewardsLoading extends RewardsState {
  const RewardsLoading();

  @override
  List<Object?> get props => [];
}

final class RewardsLoaded extends RewardsState {
  const RewardsLoaded({
    required this.data,
    required this.tierProgress,
    this.tab = RewardsTab.challenges,
  });

  final RewardsData data;
  final TierProgress tierProgress;
  final RewardsTab tab;

  int get completedChallengeCount => data.challenges
      .where((challenge) => challenge.current >= challenge.goal)
      .length;

  @override
  List<Object?> get props => [data, tierProgress, tab];
}

final class RewardsFailure extends RewardsState {
  const RewardsFailure(this.failure, {this.previous});

  final Failure failure;
  final RewardsLoaded? previous;

  @override
  List<Object?> get props => [failure, previous];
}
