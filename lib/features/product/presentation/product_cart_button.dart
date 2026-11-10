import 'package:flutter/material.dart';

import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/app/theme/app_typography.dart';
import 'package:j_dounts_app/core/motion/motion.dart';
import 'package:j_dounts_app/core/motion/reduce_motion.dart';
import 'package:j_dounts_app/core/utils/formatters.dart';
import 'package:j_dounts_app/core/widgets/press_scale.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

class ProductCartButton extends StatelessWidget {
  const ProductCartButton({
    required this.totalMmk,
    required this.addedToCart,
    required this.onPressed,
    super.key,
  });

  static const String _totalSeparator = '|';

  final int totalMmk;
  final bool addedToCart;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final label = addedToCart
        ? localizations.addedToCart.toUpperCase()
        : '${localizations.addToCart.toUpperCase()}  $_totalSeparator  '
              '${formatMmk(totalMmk)}';
    return PressScale(
      onPressed: addedToCart ? null : onPressed,
      child: AnimatedContainer(
        duration: ReduceMotion.resolve(context, Motion.badgePop),
        height: AppSpacing.primaryButtonHeight,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: addedToCart ? AppColors.successGreen : AppColors.actionBlue,
          borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
        ),
        child: Text(label, style: AppTypography.button),
      ),
    );
  }
}
