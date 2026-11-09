import 'package:flutter/material.dart';

import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({required this.visible, super.key});

  final bool visible;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      child: visible
          ? Container(
              width: double.infinity,
              color: AppColors.badgeOrange,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              child: Text(
                AppLocalizations.of(context).offlineBanner,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.surfaceCard),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
