import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:j_dounts_app/app/theme/app_theme.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key, this.home, this.router});

  final Widget? home;
  final GoRouter? router;

  @override
  Widget build(BuildContext context) {
    if (router != null && home == null) {
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
        theme: AppTheme.light,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router!,
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: AppTheme.light,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: home ?? const Scaffold(),
    );
  }
}
