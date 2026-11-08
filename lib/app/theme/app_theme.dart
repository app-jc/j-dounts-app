import 'package:flutter/material.dart';

import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_typography.dart';

abstract final class AppTheme {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: AppColors.lightColorScheme,
    scaffoldBackgroundColor: AppColors.surfaceHome,
    textTheme: AppTypography.light,
    fontFamily: AppTypography.fontFamily,
  );
}
