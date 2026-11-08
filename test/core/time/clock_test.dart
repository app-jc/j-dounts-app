import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/app/di/injection.dart';
import 'package:j_dounts_app/core/time/clock.dart';

void main() {
  setUp(() async {
    await getIt.reset();
  });

  tearDown(() async {
    await getIt.reset();
  });

  test('registers Clock as a lazy singleton', () {
    configureDependencies();

    final first = getIt<Clock>();
    final second = getIt<Clock>();

    expect(first, isA<SystemClock>());
    expect(second, same(first));
  });
}
