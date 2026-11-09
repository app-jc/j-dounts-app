import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:j_dounts_app/app/router/app_routes.dart';
import 'package:j_dounts_app/features/auth/presentation/session/session_notifier.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({required this.sessionNotifier, super.key});

  final SessionNotifier sessionNotifier;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(localizations.settingsTitle)),
      body: ListView(
        children: [
          ListTile(
            title: Text(localizations.logOut),
            onTap: () async {
              await sessionNotifier.logout();
              if (context.mounted) context.go(AppRoutes.onboarding);
            },
          ),
        ],
      ),
    );
  }
}
