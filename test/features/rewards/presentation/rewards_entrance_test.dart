import 'package:flutter/animation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/core/motion/motion.dart';
import 'package:j_dounts_app/features/rewards/presentation/rewards_entrance.dart';

void main() {
  testWidgets('entrance intervals use named durations and stagger steps', (
    tester,
  ) async {
    final controller = AnimationController(
      vsync: tester,
      duration: Motion.pointsCountUp,
    );
    addTearDown(controller.dispose);
    final entrance = RewardsEntrance(controller)
      ..configure(tierCount: 4, challengeCount: 3);

    final total = Motion.challengeArtworkFill + Motion.challengeStagger * 2;
    expect(controller.duration, total);
    expect(entrance.ring.value, 0);
    expect(entrance.count.value, 0);
    controller.value =
        Motion.pointsCountUp.inMicroseconds / 2 / total.inMicroseconds;
    expect(entrance.ring.value, closeTo(0.5, 0.000001));
    expect(entrance.count.value, closeTo(0.5, 0.000001));
    expect(entrance.tier(2).value, 0);

    controller.value = 1;
    expect(entrance.ring.value, 1);
    expect(entrance.count.value, 1);
    expect(entrance.tier(3).value, 1);
    expect(entrance.challenge(2).value, 1);
    expect(entrance.artwork(2).value, 1);
    expect(entrance.challenge(99).value, 1);
  });
}
