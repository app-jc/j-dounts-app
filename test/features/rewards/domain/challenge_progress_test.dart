import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/features/rewards/domain/challenge_progress.dart';

void main() {
  test('challenge fractions clamp and coffee 9/12 equals 0.75', () {
    expect(ChallengeProgress.fraction(9, 12), 0.75);
    expect(ChallengeProgress.fraction(-1, 4), 0);
    expect(ChallengeProgress.fraction(8, 4), 1);
    expect(ChallengeProgress.fraction(1, 0), 0);
  });

  test('donut quarters fill in order including partial progress', () {
    List<double> quarters(double progress) => List.generate(
      ChallengeProgress.donutQuarters,
      (index) => ChallengeProgress.quarterFraction(progress, index),
    );
    expect(quarters(0), [0, 0, 0, 0]);
    expect(quarters(0.125), [0.5, 0, 0, 0]);
    expect(quarters(0.25), [1, 0, 0, 0]);
    expect(quarters(0.75), [1, 1, 1, 0]);
    expect(quarters(1), [1, 1, 1, 1]);
    expect(quarters(2), [1, 1, 1, 1]);
  });
}
