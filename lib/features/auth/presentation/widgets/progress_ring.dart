import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/core/motion/motion.dart';
import 'package:j_dounts_app/core/motion/reduce_motion.dart';

class ProgressRing extends StatelessWidget {
  ProgressRing({
    required int step,
    required this.semanticLabel,
    this.isComplete = false,
    super.key,
  }) : step = _validateStep(step);

  static const int _segmentCount = 4;
  static const double _segmentProgress = 0.25;
  static const double _strokeWidth = 3;
  static const List<Color> _segmentColors = [
    AppColors.brandPink,
    AppColors.ringBlueLight,
    AppColors.actionBlue,
    AppColors.brandPink,
  ];

  final int step;
  final String semanticLabel;
  final bool isComplete;

  static int _validateStep(int step) {
    if (step < 0 || step > _segmentCount) {
      throw ArgumentError.value(step, 'step', 'Must be between 0 and 4.');
    }
    return step;
  }

  @override
  Widget build(BuildContext context) => Semantics(
    label: semanticLabel,
    child: ExcludeSemantics(
      child: SizedBox.square(
        dimension: AppSpacing.progressRingSize,
        child: AnimatedSwitcher(
          duration: ReduceMotion.resolve(context, Motion.ringMorph),
          child: isComplete
              ? _completedRing()
              : _progressRing(context, key: const ValueKey(false)),
        ),
      ),
    ),
  );

  Widget _completedRing() => Container(
    key: const ValueKey(true),
    decoration: const BoxDecoration(
      color: AppColors.brandPink,
      shape: BoxShape.circle,
    ),
    child: const Icon(Icons.check, color: AppColors.surfaceCard, size: 20),
  );

  Widget _progressRing(BuildContext context, {required Key key}) => Stack(
    key: key,
    fit: StackFit.expand,
    children: [
      for (var index = 0; index < _segmentCount; index++)
        _segment(context, index),
    ],
  );

  Widget _segment(BuildContext context, int index) {
    final color = index < step ? _segmentColors[index] : AppColors.trackGrey;
    return Transform.rotate(
      angle: math.pi / 2 * index,
      child: TweenAnimationBuilder<Color?>(
        tween: ColorTween(end: color),
        duration: ReduceMotion.resolve(context, Motion.ringProgress),
        builder: (context, animatedColor, _) => CircularProgressIndicator(
          value: _segmentProgress,
          color: animatedColor ?? AppColors.trackGrey,
          backgroundColor: Colors.transparent,
          strokeWidth: _strokeWidth,
          strokeCap: StrokeCap.round,
        ),
      ),
    );
  }
}
