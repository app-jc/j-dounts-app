import 'package:flutter/material.dart';

import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/app/theme/app_typography.dart';
import 'package:j_dounts_app/core/widgets/primary_button.dart';
import 'package:j_dounts_app/features/auth/presentation/widgets/progress_ring.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    required this.title,
    required this.progressStep,
    required this.progressLabel,
    required this.child,
    required this.onContinue,
    this.onBack,
    this.isLoading = false,
    this.isComplete = false,
    this.footer,
    super.key,
  });

  final String title;
  final int progressStep;
  final String progressLabel;
  final Widget child;
  final VoidCallback? onContinue;
  final VoidCallback? onBack;
  final bool isLoading;
  final bool isComplete;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.brandPinkSoft, AppColors.surfaceCard],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontalMargin,
                  AppSpacing.md,
                  AppSpacing.screenHorizontalMargin,
                  0,
                ),
                child: _AuthHeader(
                  onBack: onBack,
                  progressStep: progressStep,
                  progressLabel: progressLabel,
                  isComplete: isComplete,
                ),
              ),
              Expanded(
                child: _AuthContent(title: title, child: child),
              ),
              _AuthActions(
                localizations: localizations,
                onContinue: onContinue,
                isLoading: isLoading,
                footer: footer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthHeader extends StatelessWidget {
  const _AuthHeader({
    required this.onBack,
    required this.progressStep,
    required this.progressLabel,
    required this.isComplete,
  });

  final VoidCallback? onBack;
  final int progressStep;
  final String progressLabel;
  final bool isComplete;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      if (onBack == null)
        const SizedBox.square(dimension: AppSpacing.backButtonSize)
      else
        IconButton(
          onPressed: onBack,
          style: IconButton.styleFrom(
            backgroundColor: AppColors.surfaceCard,
            fixedSize: const Size.square(AppSpacing.backButtonSize),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.fieldRadius),
            ),
          ),
          icon: const Icon(Icons.arrow_back, color: AppColors.brandPink),
        ),
      const Spacer(),
      ProgressRing(
        step: progressStep,
        semanticLabel: progressLabel,
        isComplete: isComplete,
      ),
    ],
  );
}

class _AuthContent extends StatelessWidget {
  const _AuthContent({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(
      AppSpacing.screenHorizontalMargin,
      AppSpacing.lg,
      AppSpacing.screenHorizontalMargin,
      AppSpacing.xl,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: AppTypography.screenTitle),
        const SizedBox(height: AppSpacing.lg),
        child,
      ],
    ),
  );
}

class _AuthActions extends StatelessWidget {
  const _AuthActions({
    required this.localizations,
    required this.onContinue,
    required this.isLoading,
    required this.footer,
  });

  final AppLocalizations localizations;
  final VoidCallback? onContinue;
  final bool isLoading;
  final Widget? footer;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(
      AppSpacing.screenHorizontalMargin,
      AppSpacing.sm,
      AppSpacing.screenHorizontalMargin,
      AppSpacing.md,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PrimaryButton(
          label: localizations.continueLabel,
          onPressed: onContinue,
          isLoading: isLoading,
        ),
        const SizedBox(height: AppSpacing.sm),
        footer ??
            Text(
              localizations.legalAgreement,
              textAlign: TextAlign.center,
              style: AppTypography.legal,
            ),
      ],
    ),
  );
}
