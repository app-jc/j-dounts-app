import 'package:flutter/material.dart';

import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/core/motion/motion.dart';
import 'package:j_dounts_app/core/motion/reduce_motion.dart';

class ShimmerBox extends StatefulWidget {
  const ShimmerBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.semanticLabel,
  });

  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final String? semanticLabel;

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Motion.skeletonShimmer,
    )..repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ReduceMotion.isReduced(context)) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius =
        widget.borderRadius ?? BorderRadius.circular(AppSpacing.cardRadius);
    final reduced = ReduceMotion.isReduced(context);
    return Semantics(
      label: widget.semanticLabel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            gradient: LinearGradient(
              begin: Alignment(-1.5 + (_controller.value * 3), 0),
              end: Alignment(-0.5 + (_controller.value * 3), 0),
              colors: const [
                AppColors.disabledFill,
                AppColors.trackGrey,
                AppColors.disabledFill,
              ],
            ),
          ),
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: reduced ? child : null,
          ),
        ),
        child: const SizedBox.shrink(),
      ),
    );
  }
}
