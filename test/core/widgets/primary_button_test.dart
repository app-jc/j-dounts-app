import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/core/widgets/primary_button.dart';

void main() {
  testWidgets('invokes its action when enabled', (tester) async {
    var presses = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(label: 'Continue', onPressed: () => presses++),
        ),
      ),
    );

    await tester.tap(find.byType(PrimaryButton));
    await tester.pumpAndSettle();

    expect(presses, 1);
    expect(find.text('CONTINUE'), findsOneWidget);
  });

  testWidgets('disabled and loading states do not invoke the action', (
    tester,
  ) async {
    var presses = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(label: 'Continue', onPressed: () => presses++),
        ),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: PrimaryButton(label: 'Continue', onPressed: null)),
      ),
    );
    await tester.tap(find.byType(PrimaryButton));
    await tester.pump();

    expect(presses, 0);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(
            label: 'Continue',
            onPressed: () => presses++,
            isLoading: true,
          ),
        ),
      ),
    );
    await tester.tap(find.byType(PrimaryButton));
    await tester.pump();

    expect(presses, 0);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
