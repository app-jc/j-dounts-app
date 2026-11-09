import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/features/auth/presentation/widgets/progress_ring.dart';

void main() {
  testWidgets('renders its accessible step and four ring segments', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProgressRing(step: 2, semanticLabel: 'Step 2 of 4'),
        ),
      ),
    );

    expect(find.bySemanticsLabel('Step 2 of 4'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNWidgets(4));
  });

  testWidgets('morphs to a check mark when complete', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProgressRing(
            step: 4,
            semanticLabel: 'Complete',
            isComplete: true,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.check), findsOneWidget);
    expect(find.bySemanticsLabel('Complete'), findsOneWidget);
  });
}
