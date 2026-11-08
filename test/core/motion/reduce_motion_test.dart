import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/core/motion/reduce_motion.dart';

void main() {
  const duration = Duration(milliseconds: 300);
  const reducedDuration = Duration(milliseconds: 50);

  testWidgets('resolves to the requested duration when motion is enabled', (
    tester,
  ) async {
    late Duration resolved;
    late bool isReduced;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            isReduced = ReduceMotion.isReduced(context);
            resolved = ReduceMotion.resolve(context, duration);
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(isReduced, isFalse);
    expect(resolved, duration);
  });

  testWidgets('uses the reduced duration when animations are disabled', (
    tester,
  ) async {
    late Duration resolved;
    late Duration skipped;
    late bool isReduced;

    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: Builder(
            builder: (context) {
              isReduced = ReduceMotion.isReduced(context);
              resolved = ReduceMotion.resolve(
                context,
                duration,
                reduced: reducedDuration,
              );
              skipped = ReduceMotion.resolve(context, duration);
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );

    expect(isReduced, isTrue);
    expect(resolved, reducedDuration);
    expect(skipped, Duration.zero);
  });
}
