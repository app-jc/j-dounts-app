import 'package:flutter/material.dart';

import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/app/theme/app_typography.dart';
import 'package:j_dounts_app/core/widgets/press_scale.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null && !isLoading;
    final backgroundColor = isDisabled
        ? AppColors.disabledFill
        : AppColors.actionBlue;
    final foregroundColor = isDisabled
        ? AppColors.disabledLabel
        : AppColors.surfaceCard;

    return PressScale(
      onPressed: isLoading ? null : onPressed,
      child: Semantics(
        label: label,
        value: isLoading ? label : null,
        child: Container(
          height: AppSpacing.primaryButtonHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
          ),
          alignment: Alignment.center,
          child: isLoading
              ? SizedBox.square(
                  dimension: AppSpacing.lg,
                  child: CircularProgressIndicator(
                    color: foregroundColor,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  label.toUpperCase(),
                  style: AppTypography.button.copyWith(color: foregroundColor),
                ),
        ),
      ),
    );
  }
}
