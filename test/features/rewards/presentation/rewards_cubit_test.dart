import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/core/member/domain/member.dart';
import 'package:j_dounts_app/features/rewards/domain/rewards_data.dart';
import 'package:j_dounts_app/features/rewards/domain/rewards_repository.dart';
import 'package:j_dounts_app/features/rewards/domain/tier_calculator.dart';
import 'package:j_dounts_app/features/rewards/presentation/rewards_cubit.dart';
import 'package:j_dounts_app/features/rewards/presentation/rewards_state.dart';

const _memberId = 42;
const _tiers = [
  TierDefinition(name: 'Bronze', threshold: 0),
  TierDefinition(name: 'Silver', threshold: 679000),
  TierDefinition(name: 'Gold', threshold: 680500),
  TierDefinition(name: 'Platinum', threshold: 700000),
];

RewardsData _rewards(int points) => RewardsData(
  member: Member(
    id: _memberId,
    phone: '+95912345678',
    firstName: 'Demo',
    lastName: null,
    dateOfBirth: DateTime(1990),
    photo: null,
    totalPoints: points,
    notificationCount: 0,
  ),
  tiers: _tiers,
  challenges: const [],
  gifts: const [],
);

void main() {
  late _RewardsRepository repository;
  late RewardsCubit cubit;

  setUp(() {
    repository = _RewardsRepository();
    cubit = RewardsCubit(repository, memberId: _memberId);
  });

  tearDown(() async {
    if (!cubit.isClosed) await cubit.close();
    await repository.close();
  });

  test('follows member updates and recalculates tier progress', () async {
    expect(cubit.state, isA<RewardsLoading>());
    expect(repository.memberIds, [_memberId]);

    repository.current.add(Success(_rewards(680000)));
    await pumpEventQueue();
    final first = cubit.state as RewardsLoaded;
    expect(first.data.member?.totalPoints, 680000);
    final firstProgress = first.tierProgress as HasNextTier;
    expect(firstProgress.currentTier.name, 'Silver');
    expect(firstProgress.remaining, 500);
    expect(firstProgress.fraction, closeTo(1000 / 1500, 0.000001));

    repository.current.add(Success(_rewards(680500)));
    await pumpEventQueue();
    final updated = cubit.state as RewardsLoaded;
    expect(updated.data.member?.totalPoints, 680500);
    final updatedProgress = updated.tierProgress as HasNextTier;
    expect(updatedProgress.currentTier.name, 'Gold');
    expect(updatedProgress.remaining, 19500);
    expect(updatedProgress.fraction, 0);
  });

  test(
    'zero-point member has empty tier progress and 679000 until Silver',
    () async {
      repository.current.add(Success(_rewards(0)));
      await pumpEventQueue();

      final loaded = cubit.state as RewardsLoaded;
      final progress = loaded.tierProgress as HasNextTier;
      expect(progress.currentTier.name, 'Bronze');
      expect(progress.nextTier.name, 'Silver');
      expect(progress.remaining, 679000);
      expect(progress.fraction, 0);
    },
  );

  test('retains cached data on failure and retries the repository', () async {
    repository.current.add(Success(_rewards(680000)));
    await pumpEventQueue();
    final previous = cubit.state as RewardsLoaded;

    repository.current.add(const FailureResult(StorageFailure()));
    await pumpEventQueue();
    final failure = cubit.state as RewardsFailure;
    expect(failure.failure, isA<StorageFailure>());
    expect(failure.previous, previous);

    await cubit.retry();
    expect(repository.memberIds, [_memberId, _memberId]);
    expect(repository.cancelledSubscriptions, 1);
    repository.current.add(Success(_rewards(680500)));
    await pumpEventQueue();
    expect((cubit.state as RewardsLoaded).data.member?.totalPoints, 680500);
  });

  test('cancels the repository subscription when closed', () async {
    await cubit.close();
    expect(repository.cancelledSubscriptions, 1);
  });

  test('preserves selected tab across member updates and retry', () async {
    repository.current.add(Success(_rewards(680000)));
    await pumpEventQueue();
    cubit.selectTab(RewardsTab.gifts);
    expect((cubit.state as RewardsLoaded).tab, RewardsTab.gifts);

    repository.current.add(Success(_rewards(680500)));
    await pumpEventQueue();
    expect((cubit.state as RewardsLoaded).tab, RewardsTab.gifts);
    repository.current.add(const FailureResult(StorageFailure()));
    await pumpEventQueue();
    await cubit.retry();
    repository.current.add(Success(_rewards(680500)));
    await pumpEventQueue();
    expect((cubit.state as RewardsLoaded).tab, RewardsTab.gifts);
    cubit.selectTab(RewardsTab.challenges);
    expect((cubit.state as RewardsLoaded).tab, RewardsTab.challenges);
  });
}

final class _RewardsRepository implements RewardsRepository {
  final memberIds = <int>[];
  final controllers = <StreamController<Result<RewardsData>>>[];
  int cancelledSubscriptions = 0;

  StreamController<Result<RewardsData>> get current => controllers.last;

  @override
  Stream<Result<RewardsData>> watchRewards(int memberId) {
    memberIds.add(memberId);
    final controller = StreamController<Result<RewardsData>>(
      onCancel: () => cancelledSubscriptions++,
    );
    controllers.add(controller);
    return controller.stream;
  }

  Future<void> close() async {
    for (final controller in controllers) {
      await controller.close();
    }
  }
}
