import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/features/auth/presentation/widgets/otp_boxes.dart';

void main() {
  testWidgets('renders six boxes and accepts pasted digits', (tester) async {
    var value = '';
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 320,
            child: OtpBoxes(value: value, onChanged: (next) => value = next),
          ),
        ),
      ),
    );

    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(Container), findsNWidgets(6));

    await tester.enterText(find.byType(TextField), '123456');
    expect(value, '123456');
  });

  testWidgets('Done dismisses OTP focus and invokes submit', (tester) async {
    var submitted = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 320,
            child: OtpBoxes(
              value: '',
              onChanged: (_) {},
              onSubmitted: () => submitted++,
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    final focus = tester.widget<TextField>(find.byType(TextField)).focusNode!;
    expect(focus.hasFocus, isTrue);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    expect(focus.hasFocus, isFalse);
    expect(submitted, 1);
  });
}
