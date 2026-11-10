import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/core/member/domain/member.dart';
import 'package:j_dounts_app/features/home/presentation/home_shell_widgets.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

void main() {
  testWidgets('notification icon displays its badge and invokes its action', (
    tester,
  ) async {
    var actions = 0;
    final member = Member(
      id: 1,
      phone: '+95912345678',
      firstName: 'Demo',
      lastName: null,
      dateOfBirth: DateTime(1990),
      photo: null,
      totalPoints: 0,
      notificationCount: 2,
    );
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: HomeMemberHeader(
            member: member,
            progress: null,
            onSettings: () => actions++,
          ),
        ),
      ),
    );
    final button = find.ancestor(
      of: find.byIcon(Icons.notifications_none_outlined),
      matching: find.byType(IconButton),
    );
    expect(tester.widget<IconButton>(button).onPressed, isNotNull);
    expect(find.text('2'), findsOneWidget);
    await tester.tap(button);
    await tester.pump();
    expect(actions, 1);
  });
}
