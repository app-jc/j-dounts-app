import 'package:flutter/animation.dart';

import 'package:j_dounts_app/core/motion/motion.dart';

final class RewardsEntrance {
  const RewardsEntrance(this.controller);

  final AnimationController controller;

  void configure({required int tierCount, required int challengeCount}) {
    final durations = [
      Motion.pointsRingSweep,
      Motion.pointsCountUp,
      Motion.ladderFill,
      Motion.earnAttention,
      Motion.badgePop,
      _staggerDuration(Motion.ladderAppear, Motion.ladderStagger, tierCount),
      _staggerDuration(
        Motion.challengeAppear,
        Motion.challengeStagger,
        challengeCount,
      ),
      _staggerDuration(
        Motion.challengeArtworkFill,
        Motion.challengeStagger,
        challengeCount,
      ),
    ];
    controller.duration = durations.reduce((a, b) => a > b ? a : b);
  }

  Duration _staggerDuration(Duration duration, Duration step, int count) =>
      duration + step * (count > 0 ? count - 1 : 0);

  Animation<double> get ring => _animation(Motion.pointsRingSweep);
  Animation<double> get count => _animation(Motion.pointsCountUp);
  Animation<double> get ladderFill => _animation(Motion.ladderFill);
  Animation<double> get earn => _animation(Motion.earnAttention);
  Animation<double> get badge =>
      _animation(Motion.badgePop, curve: Motion.popCurve);

  Animation<double> tier(int index) => _animation(
    Motion.ladderAppear,
    start: Motion.ladderStagger * index,
    curve: Motion.standardCurve,
  );

  Animation<double> challenge(int index) => _animation(
    Motion.challengeAppear,
    start: Motion.challengeStagger * index,
    curve: Motion.standardCurve,
  );

  Animation<double> artwork(int index) => _animation(
    Motion.challengeArtworkFill,
    start: Motion.challengeStagger * index,
    curve: Motion.standardCurve,
  );

  Animation<double> _animation(
    Duration duration, {
    Duration start = Duration.zero,
    Curve curve = Curves.linear,
  }) {
    final total = controller.duration!.inMicroseconds;
    final length = duration.inMicroseconds.clamp(1, total);
    final offset = start.inMicroseconds.clamp(0, total - length);
    return controller.drive(
      CurveTween(
        curve: Interval(
          offset / total,
          (offset + length) / total,
          curve: curve,
        ),
      ),
    );
  }
}
