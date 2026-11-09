import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color brandPink = Color(0xFFE87DAE);
  static const Color brandPinkSoft = Color(0xFFFBEFF4);
  static const Color actionBlue = Color(0xFF8AD5ED);
  static const Color ringBlueLight = Color(0xFFBEE4F8);
  static const Color badgeOrange = Color(0xFFF4994C);
  static const Color surfaceHome = Color(0xFFF1F3F4);
  static const Color headerPeach = Color(0xFFFDF0E4);
  static const Color surfaceCard = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF232323);
  static const Color textSecondary = Color(0xFF82868B);
  static const Color disabledFill = Color(0xFFECECEC);
  static const Color disabledLabel = Color(0xFFFFFFFF);
  static const Color trackGrey = Color(0xFFF1F3F4);
  static const Color successGreen = Color(0xFFA3C66C);
  static const Color bannerPurple = Color(0xFF7070B2);
  static const Color bannerBlue = Color(0xFF8AD5ED);
  static const Color scrim = Color(0x42000000);

  static final ColorScheme lightColorScheme = ColorScheme.light(
    primary: actionBlue,
    onPrimary: surfaceCard,
    secondary: brandPink,
    onSecondary: surfaceCard,
    surface: surfaceCard,
    onSurface: textPrimary,
  );
}
