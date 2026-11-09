import 'package:flutter/material.dart';

import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_typography.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

class LegalFooter extends StatelessWidget {
  const LegalFooter({
    required this.onTermsTap,
    required this.onPrivacyTap,
    super.key,
  });

  final VoidCallback onTermsTap;
  final VoidCallback onPrivacyTap;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final linkStyle = AppTypography.legal.copyWith(color: AppColors.brandPink);
    return Text.rich(
      TextSpan(
        style: AppTypography.legal,
        children: [
          TextSpan(text: localizations.legalAgreementPrefix),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: InkWell(
              onTap: onTermsTap,
              child: Text(localizations.termsOfUse, style: linkStyle),
            ),
          ),
          TextSpan(text: localizations.legalAgreementJoin),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: InkWell(
              onTap: onPrivacyTap,
              child: Text(localizations.privacyPolicy, style: linkStyle),
            ),
          ),
          TextSpan(text: localizations.legalAgreementSuffix),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
