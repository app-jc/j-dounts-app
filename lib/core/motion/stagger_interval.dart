import 'package:flutter/animation.dart';

import 'package:j_dounts_app/core/motion/motion.dart';

abstract final class StaggerInterval {
  static Duration durationFor(int itemCount) {
    assert(itemCount > 0);
    return Motion.onboardingDrift + Motion.staggerStep * (itemCount - 1);
  }

  static Interval forItem(int index, int itemCount) {
    assert(itemCount > 0);
    assert(index >= 0 && index < itemCount);
    final totalMicros = durationFor(itemCount).inMicroseconds;
    final startMicros = (Motion.staggerStep * index).inMicroseconds;
    final endMicros =
        (Motion.staggerStep * index + Motion.onboardingDrift).inMicroseconds;
    return Interval(
      startMicros / totalMicros,
      endMicros / totalMicros,
      curve: Motion.emphasizedCurve,
    );
  }
}
