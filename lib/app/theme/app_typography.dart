import 'package:flutter/material.dart';

import 'package:j_dounts_app/app/theme/app_colors.dart';

abstract final class AppTypography {
  static const String fontFamily = 'Nunito';
  static const List<String> fontFamilyFallback = <String>['Noto Sans Myanmar'];

  static const TextStyle displayTitle = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    fontSize: 32,
    fontWeight: FontWeight.w800,
    height: 1.15,
    color: AppColors.textPrimary,
  );

  static const TextStyle screenTitle = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    height: 1.15,
    color: AppColors.textPrimary,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.2,
    color: AppColors.textPrimary,
  );

  static const TextStyle cardTitle = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.2,
    color: AppColors.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.35,
    color: AppColors.textPrimary,
  );

  static const TextStyle fieldText = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.2,
    color: AppColors.textPrimary,
  );

  static const TextStyle fieldHint = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.2,
    color: AppColors.textSecondary,
  );

  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1,
    color: AppColors.surfaceCard,
  );

  static const TextStyle legal = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    height: 1.3,
    color: AppColors.textSecondary,
  );

  static const TextStyle numberLarge = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.1,
    color: AppColors.textPrimary,
  );

  static const TextTheme light = TextTheme(
    displayLarge: displayTitle,
    headlineMedium: screenTitle,
    titleLarge: sectionTitle,
    titleMedium: cardTitle,
    bodyLarge: body,
    bodyMedium: fieldText,
    bodySmall: legal,
    labelLarge: button,
  );
}
