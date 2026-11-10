import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:j_dounts_app/app/shell/placeholder_screen.dart';
import 'package:j_dounts_app/app/router/app_routes.dart';
import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/features/auth/presentation/session/session_notifier.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({required this.sessionNotifier, super.key});

  final SessionNotifier sessionNotifier;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.surfaceHome,
      appBar: AppBar(
        title: Text(localizations.settingsTitle),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton.icon(
              onPressed: () async {
                await sessionNotifier.logout();
                if (context.mounted) context.go(AppRoutes.onboarding);
              },
              icon: const Icon(Icons.logout_rounded),
              label: Text(localizations.logOut),
              style: TextButton.styleFrom(foregroundColor: AppColors.brandPink),
            ),
          ),
        ],
      ),
      body: FeaturePlaceholderContent(
        title: localizations.settingsPlaceholderTitle,
        message: localizations.settingsPlaceholderMessage,
        icon: Icons.tune_rounded,
        accentColor: AppColors.actionBlue,
      ),
    );
  }
}
