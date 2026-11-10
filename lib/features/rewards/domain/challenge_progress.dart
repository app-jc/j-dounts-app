abstract final class ChallengeProgress {
  static const int donutQuarters = 4;

  static double fraction(int current, int goal) =>
      goal > 0 ? (current / goal).clamp(0.0, 1.0) : 0.0;

  static double quarterFraction(double progress, int index) {
    assert(index >= 0 && index < donutQuarters);
    return (progress.clamp(0.0, 1.0) * donutQuarters - index).clamp(0.0, 1.0);
  }
}
