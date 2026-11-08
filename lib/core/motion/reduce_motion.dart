import 'package:flutter/widgets.dart';

abstract final class ReduceMotion {
  static bool isReduced(BuildContext context) =>
      MediaQuery.disableAnimationsOf(context);

  static Duration resolve(
    BuildContext context,
    Duration duration, {
    Duration reduced = Duration.zero,
  }) {
    return isReduced(context) ? reduced : duration;
  }
}
