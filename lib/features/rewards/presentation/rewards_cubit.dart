import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/features/rewards/domain/rewards_data.dart';
import 'package:j_dounts_app/features/rewards/domain/rewards_repository.dart';
import 'package:j_dounts_app/features/rewards/domain/tier_calculator.dart';
import 'package:j_dounts_app/features/rewards/presentation/rewards_state.dart';

final class RewardsCubit extends Cubit<RewardsState> {
  RewardsCubit(this._repository, {required this.memberId})
    : super(const RewardsLoading()) {
    _subscribe();
  }

  final RewardsRepository _repository;
  final int memberId;
  StreamSubscription<Result<RewardsData>>? _subscription;
  bool _retrying = false;
  bool _closing = false;
  RewardsTab _tab = RewardsTab.challenges;

  RewardsLoaded? get _previous => switch (state) {
    final RewardsLoaded loaded => loaded,
    RewardsFailure(:final previous) => previous,
    RewardsLoading() => null,
  };

  void _subscribe() {
    _subscription = _repository
        .watchRewards(memberId)
        .listen(
          _onResult,
          onError: (Object error, StackTrace stackTrace) {
            addError(error, stackTrace);
            emit(
              RewardsFailure(
                UnexpectedFailure(cause: error),
                previous: _previous,
              ),
            );
          },
        );
  }

  void _onResult(Result<RewardsData> result) {
    result.fold(
      onFailure: (failure) =>
          emit(RewardsFailure(failure, previous: _previous)),
      onSuccess: _onData,
    );
  }

  void _onData(RewardsData data) {
    final member = data.member;
    if (member == null) {
      emit(RewardsFailure(const NotFoundFailure(), previous: _previous));
      return;
    }
    try {
      final progress = TierCalculator(data.tiers).calculate(member.totalPoints);
      emit(RewardsLoaded(data: data, tierProgress: progress, tab: _tab));
    } on ArgumentError catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(
        RewardsFailure(UnexpectedFailure(cause: error), previous: _previous),
      );
    }
  }

  void selectTab(RewardsTab tab) {
    if (_tab == tab) return;
    _tab = tab;
    final loaded = _previous;
    if (loaded == null) return;
    final updated = RewardsLoaded(
      data: loaded.data,
      tierProgress: loaded.tierProgress,
      tab: tab,
    );
    final current = state;
    if (current is RewardsFailure) {
      emit(RewardsFailure(current.failure, previous: updated));
    } else {
      emit(updated);
    }
  }

  Future<void> retry() async {
    if (_retrying || _closing) return;
    _retrying = true;
    try {
      await _subscription?.cancel();
      if (_closing || isClosed) return;
      if (_previous == null) emit(const RewardsLoading());
      _subscribe();
    } finally {
      _retrying = false;
    }
  }

  @override
  Future<void> close() async {
    _closing = true;
    await _subscription?.cancel();
    return super.close();
  }
}
