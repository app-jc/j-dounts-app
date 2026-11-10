import 'package:flutter/material.dart';

import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    required this.title,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: actionLabel == null || onAction == null
            ? Text(title)
            : TextButton(onPressed: onAction, child: Text(actionLabel!)),
      ),
    );
  }
}

class FeaturePlaceholderScreen extends StatelessWidget {
  const FeaturePlaceholderScreen({
    required this.title,
    required this.headline,
    required this.message,
    required this.icon,
    required this.accentColor,
    super.key,
  });

  final String title;
  final String headline;
  final String message;
  final IconData icon;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceHome,
      appBar: AppBar(title: Text(title)),
      body: FeaturePlaceholderContent(
        title: headline,
        message: message,
        icon: icon,
        accentColor: accentColor,
      ),
    );
  }
}

class FeaturePlaceholderContent extends StatelessWidget {
  const FeaturePlaceholderContent({
    required this.title,
    required this.message,
    required this.icon,
    required this.accentColor,
    super.key,
  });

  final String title;
  final String message;
  final IconData icon;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _PlaceholderArtwork(icon: icon, accentColor: accentColor),
                const SizedBox(height: AppSpacing.xl),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    child: Text(
                      AppLocalizations.of(context).comingSoon,
                      style: Theme.of(context).textTheme.labelLarge
                          ?.copyWith(color: accentColor),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge
                      ?.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlaceholderArtwork extends StatelessWidget {
  const _PlaceholderArtwork({required this.icon, required this.accentColor});

  final IconData icon;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 224,
      height: 224,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 16,
            right: 12,
            child: _Dot(color: accentColor.withValues(alpha: 0.22), size: 22),
          ),
          Positioned(
            bottom: 24,
            left: 8,
            child: _Dot(
              color: AppColors.actionBlue.withValues(alpha: 0.5),
              size: 14,
            ),
          ),
          Container(
            width: 176,
            height: 176,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  accentColor.withValues(alpha: 0.2),
                  accentColor.withValues(alpha: 0.06),
                ],
              ),
            ),
          ),
          Container(
            width: 128,
            height: 128,
            decoration: BoxDecoration(
              color: AppColors.surfaceCard,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.16),
                  blurRadius: 28,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Icon(icon, size: 60, color: accentColor),
          ),
          Positioned(
            top: 42,
            left: 32,
            child: _Dot(color: AppColors.badgeOrange, size: 10),
          ),
          Positioned(
            bottom: 42,
            right: 26,
            child: _Dot(color: AppColors.successGreen, size: 12),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: SizedBox.square(dimension: size),
    );
  }
}
