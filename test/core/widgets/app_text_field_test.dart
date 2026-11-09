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
}
