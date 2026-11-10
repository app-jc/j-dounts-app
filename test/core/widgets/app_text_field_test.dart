import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/core/widgets/app_text_field.dart';

void main() {
  late TextEditingController controller;

  setUp(() {
    controller = TextEditingController();
  });

  tearDown(() {
    controller.dispose();
  });

  testWidgets('accepts input and announces an error message', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppTextField(
            controller: controller,
            hintText: 'First name',
            errorText: 'Enter a first name',
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Charlotte');
    await tester.pumpAndSettle();

    expect(controller.text, 'Charlotte');
    expect(find.text('Enter a first name'), findsOneWidget);
    expect(find.byType(AppTextField), findsOneWidget);
  });

  testWidgets('Done dismisses focus and invokes submit', (tester) async {
    var submitted = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppTextField(
            controller: controller,
            hintText: 'Name',
            textInputAction: TextInputAction.done,
            onSubmitted: () => submitted++,
          ),
        ),
      ),
    );
    await tester.tap(find.byType(TextField));
    await tester.pump();
    final focus = tester.widget<TextField>(find.byType(TextField)).focusNode!;
    expect(focus.hasFocus, isTrue);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    expect(focus.hasFocus, isFalse);
    expect(submitted, 1);
  });
}
