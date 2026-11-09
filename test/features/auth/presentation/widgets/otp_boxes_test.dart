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
}
