// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/app/app.dart';
import 'package:j_dounts_app/app/theme/app_theme.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

void main() {
  testWidgets('app starts with shared theme and supported localizations', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const App());

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.theme, AppTheme.light);
    expect(app.supportedLocales, contains(const Locale('en')));
    expect(app.supportedLocales, contains(const Locale('my')));
    expect(app.localizationsDelegates, contains(AppLocalizations.delegate));
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
