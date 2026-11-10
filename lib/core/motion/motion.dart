import 'package:flutter/animation.dart';

abstract final class Motion {
  static const Duration short = Duration(milliseconds: 150);
  static const Duration standard = Duration(milliseconds: 300);
  static const Duration long = Duration(milliseconds: 500);

  static const Curve standardCurve = Curves.easeInOutCubic;
  static const Curve emphasizedCurve = Curves.easeOutCubic;
  static const Curve popCurve = Curves.easeOutBack;
  static const Curve attentionCurve = Curves.easeOutBack;
  static const Curve shimmerCurve = Curves.linear;

  static const Duration onboardingDrift = long;
  static const Duration staggerStep = short;
  static const Duration stepTransition = standard;
  static const Duration ringProgress = long;
  static const Duration ringMorph = standard;
  static const Duration otpShake = short;
  static const Duration fieldFocus = short;
  static const Duration buttonPress = short;
  static const Duration buttonLoadingMorph = standard;
  static const Duration welcomeStagger = short;
  static const Duration skeletonShimmer = long;
  static const Duration sectionStagger = short;
  static const Duration carouselInterval = Duration(seconds: 4);
  static const Duration heroTransition = standard;
  static const Duration quantityChange = short;
  static const Duration navPillSlide = standard;
  static const Duration pointsRingSweep = long;
  static const Duration pointsCountUp = long;
  static const Duration ladderAppear = standard;
  static const Duration ladderStagger = staggerStep;
  static const Duration ladderFill = long;
  static const Duration tabIndicator = standard;
  static const Duration tabListSwitch = short;
  static const Duration challengeStagger = short;
  static const Duration challengeAppear = standard;
  static const Duration challengeArtworkFill = long;
  static const Duration earnAttention = long;
  static const Duration badgePop = standard;
}
