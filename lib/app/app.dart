import 'package:flutter/material.dart';

import 'package:j_dounts_app/app/theme/app_theme.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key, this.home});

  final Widget? home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: AppTheme.light,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: home ?? const Scaffold(),
    );
  }
}
