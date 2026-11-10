import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/features/rewards/domain/challenge_progress.dart';

class RewardsRingPainter extends CustomPainter {
  const RewardsRingPainter(this.fraction);

  final double fraction;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = size.shortestSide * 0.19;
    final rect = Offset.zero & size;
    final arc = rect.deflate(stroke / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(
      rect.center,
      arc.width / 2,
      paint..color = AppColors.trackGrey,
    );
    final sweep = fraction.clamp(0.0, 1.0) * math.pi * 2;
    if (sweep <= 0) return;
    paint.shader = const SweepGradient(
      colors: [
        AppColors.brandPink,
        AppColors.brandPinkSoft,
        AppColors.brandPink,
      ],
    ).createShader(rect);
    canvas.drawArc(arc, -math.pi / 2, sweep, false, paint);
    final sprinklePaint = Paint()
      ..color = AppColors.surfaceCard.withValues(alpha: 0.65)
      ..strokeWidth = stroke * 0.07
      ..strokeCap = StrokeCap.round;
    for (var index = 0; index < 16; index++) {
      final angle = math.pi * 2 * (index + 0.5) / 16;
      if (angle >= sweep) break;
      final theta = angle - math.pi / 2;
      final distance = arc.width / 2;
      final point =
          rect.center + Offset(math.cos(theta), math.sin(theta)) * distance;
      final tangent = Offset(-math.sin(theta), math.cos(theta)) * stroke * 0.12;
      canvas.drawLine(point - tangent, point + tangent, sprinklePaint);
    }
  }

  @override
  bool shouldRepaint(RewardsRingPainter oldDelegate) =>
      oldDelegate.fraction != fraction;
}

class ChallengeArtworkPainter extends CustomPainter {
  const ChallengeArtworkPainter({required this.type, required this.progress});

  final String type;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = size.shortestSide * 0.34;
    final stroke = radius * 0.52;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    if (type == 'coffee') {
      final arc = Rect.fromCircle(center: center, radius: radius);
      canvas.drawArc(
        arc,
        math.pi * 0.75,
        math.pi * 1.5,
        false,
        paint..color = AppColors.disabledFill,
      );
      if (progress > 0) {
        canvas.drawArc(
          arc,
          math.pi * 0.75,
          math.pi * 1.5 * progress.clamp(0.0, 1.0),
          false,
          paint..color = AppColors.badgeOrange,
        );
      }
      final cup = Paint()..color = AppColors.textSecondary;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: center, width: radius, height: radius * 0.8),
          Radius.circular(radius * 0.2),
        ),
        cup,
      );
      return;
    }
    canvas.drawCircle(center, radius, paint..color = AppColors.disabledFill);
    for (var index = 0; index < ChallengeProgress.donutQuarters; index++) {
      final fill = ChallengeProgress.quarterFraction(progress, index);
      if (fill == 0) continue;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2 + index * math.pi / 2,
        math.pi / 2 * fill,
        false,
        paint
          ..strokeCap = StrokeCap.butt
          ..color = AppColors.brandPink,
      );
    }
  }

  @override
  bool shouldRepaint(ChallengeArtworkPainter oldDelegate) =>
      oldDelegate.type != type || oldDelegate.progress != progress;
}
