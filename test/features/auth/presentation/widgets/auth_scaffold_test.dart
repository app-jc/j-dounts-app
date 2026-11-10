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

  testWidgets('Continue and Back dismiss focus and invoke callbacks', (
    tester,
  ) async {
    final focus = FocusNode();
    addTearDown(focus.dispose);
    var actions = 0;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: AuthScaffold(
          title: 'Title',
          progressStep: 1,
          progressLabel: 'Step',
          onContinue: () => actions++,
          onBack: () => actions++,
          child: TextField(focusNode: focus),
        ),
      ),
    );
    await tester.tap(find.byType(TextField));
    await tester.pump();
    expect(focus.hasFocus, isTrue);
    await tester.tap(find.text('CONTINUE'));
    await tester.pump();
    expect(focus.hasFocus, isFalse);
    await tester.tap(find.byType(TextField));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pump();
    expect(focus.hasFocus, isFalse);
    expect(actions, 2);
  });
}
