import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/app/theme/app_theme.dart';
import 'package:j_dounts_app/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

void main() {
  testWidgets('shows localized actions, progress, and content', (tester) async {
    var continueCount = 0;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: AuthScaffold(
          title: 'Enter your phone number',
          progressStep: 1,
          progressLabel: 'Step 1 of 4',
          onContinue: () => continueCount++,
          child: const Text('Form content'),
        ),
      ),
    );

    expect(find.text('Enter your phone number'), findsOneWidget);
    expect(find.text('Form content'), findsOneWidget);
    expect(find.text('CONTINUE'), findsOneWidget);
    expect(find.textContaining('Terms of Use'), findsOneWidget);

    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();

    expect(continueCount, 1);
  });
}
