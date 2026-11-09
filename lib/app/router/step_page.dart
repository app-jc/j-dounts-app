import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:j_dounts_app/core/motion/motion.dart';
import 'package:j_dounts_app/core/motion/reduce_motion.dart';

CustomTransitionPage<void> stepPage({
  required LocalKey key,
  required Widget child,
}) => CustomTransitionPage<void>(
  key: key,
  transitionDuration: Motion.stepTransition,
  reverseTransitionDuration: Motion.stepTransition,
  child: child,
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
    if (ReduceMotion.isReduced(context)) return child;

    final position = Tween<Offset>(
      begin: const Offset(0.08, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: Motion.standardCurve));
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(position: position, child: child),
    );
  },
);
