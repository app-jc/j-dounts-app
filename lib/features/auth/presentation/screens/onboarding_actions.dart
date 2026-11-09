import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/app/theme/app_typography.dart';
import 'package:j_dounts_app/core/widgets/legal_footer.dart';
import 'package:j_dounts_app/core/widgets/primary_button.dart';
import 'package:j_dounts_app/core/widgets/staggered_entrance.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

class OnboardingActions extends StatelessWidget {
  const OnboardingActions({
    required this.localizations,
    required this.entrances,
    required this.onRegister,
    required this.onLogin,
    required this.onPlaceholder,
    super.key,
  });

  final AppLocalizations localizations;
  final List<Animation<double>> entrances;
  final VoidCallback onRegister;
  final VoidCallback onLogin;
  final VoidCallback onPlaceholder;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      StaggeredEntrance(
        entrance: entrances[0],
        child: Text(
          localizations.onboardingTitle,
          textAlign: TextAlign.center,
          style: AppTypography.displayTitle,
        ),
      ),
      const SizedBox(height: AppSpacing.lg),
      OnboardingStartButton(
        label: localizations.getStarted,
        entrance: entrances[1],
        onPressed: onRegister,
      ),
      OnboardingLoginRow(
        alreadyHaveAccount: localizations.alreadyHaveAccount,
        logIn: localizations.logIn,
        entrance: entrances[2],
        onPressed: onLogin,
      ),
      OnboardingSocialRow(
        localizations: localizations,
        entrance: entrances[3],
        onPressed: onPlaceholder,
      ),
      const SizedBox(height: AppSpacing.sm),
      StaggeredEntrance(
        entrance: entrances[4],
        child: LegalFooter(
          onTermsTap: onPlaceholder,
          onPrivacyTap: onPlaceholder,
        ),
      ),
    ],
  );
}

class OnboardingStartButton extends StatelessWidget {
  const OnboardingStartButton({
    required this.label,
    required this.entrance,
    required this.onPressed,
    super.key,
  });

  final String label;
  final Animation<double> entrance;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => StaggeredEntrance(
    entrance: entrance,
    child: PrimaryButton(label: label, onPressed: onPressed),
  );
}

class OnboardingLoginRow extends StatelessWidget {
  const OnboardingLoginRow({
    required this.alreadyHaveAccount,
    required this.logIn,
    required this.entrance,
    required this.onPressed,
    super.key,
  });

  final String alreadyHaveAccount;
  final String logIn;
  final Animation<double> entrance;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => StaggeredEntrance(
    entrance: entrance,
    child: Center(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(alreadyHaveAccount, style: AppTypography.body),
          TextButton(
            onPressed: onPressed,
            child: Text(
              logIn,
              style: const TextStyle(color: AppColors.brandPink),
            ),
          ),
        ],
      ),
    ),
  );
}

class OnboardingSocialRow extends StatelessWidget {
  const OnboardingSocialRow({
    required this.localizations,
    required this.entrance,
    required this.onPressed,
    super.key,
  });

  final AppLocalizations localizations;
  final Animation<double> entrance;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => StaggeredEntrance(
    entrance: entrance,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialButton(
          FontAwesomeIcons.google,
          localizations.continueWithGoogle,
          onPressed,
        ),
        _SocialButton(
          FontAwesomeIcons.apple,
          localizations.continueWithApple,
          onPressed,
        ),
        _SocialButton(
          FontAwesomeIcons.facebook,
          localizations.continueWithFacebook,
          onPressed,
        ),
      ],
    ),
  );
}

class _SocialButton extends StatelessWidget {
  const _SocialButton(this.icon, this.label, this.onPressed);

  final FaIconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => IconButton(
    tooltip: label,
    onPressed: onPressed,
    icon: FaIcon(icon, color: AppColors.textPrimary),
  );
}
