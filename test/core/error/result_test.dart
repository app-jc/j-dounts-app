import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/core/error/result.dart';

FailureType failureType(Failure failure) => switch (failure) {
  ValidationFailure() => FailureType.validation,
  NetworkFailure() => FailureType.network,
  StorageFailure() => FailureType.storage,
  NotFoundFailure() => FailureType.notFound,
  UnexpectedFailure() => FailureType.unexpected,
  ConflictFailure() => FailureType.conflict,
  AuthFailure() => FailureType.auth,
};

String describeIntResult(Result<int> result) => switch (result) {
  Success<int>(value: final value) => 'success:$value',
  FailureResult<int>(failure: final failure) => 'failure:${failure.type.name}',
};

void main() {
  group('Result equality', () {
    test('success values determine equality', () {
      expect(const Success<int>(4), const Success<int>(4));
      expect(const Success<int>(4), isNot(const Success<int>(5)));
    });

    test('failure result equality follows failure equality', () {
      expect(
        const FailureResult<int>(NetworkFailure()),
        const FailureResult<int>(NetworkFailure()),
      );
      expect(
        const FailureResult<int>(NetworkFailure()),
        isNot(const FailureResult<int>(StorageFailure())),
      );
    });

    test('failure technical cause does not affect equality', () {
      expect(
        FailureResult<int>(NetworkFailure(cause: Exception('first'))),
        FailureResult<int>(NetworkFailure(cause: Exception('second'))),
      );
    });
  });

  group('Failure variants', () {
    test('each variant exposes its failure type exhaustively', () {
      final failures = <Failure>[
        const ValidationFailure(),
        const NetworkFailure(),
        const StorageFailure(),
        const NotFoundFailure(),
        const UnexpectedFailure(),
        const ConflictFailure(code: ConflictFailureCode.duplicatePhone),
        const AuthFailure(code: AuthFailureCode.notRegistered),
        const AuthFailure(code: AuthFailureCode.wrongOtp),
        const AuthFailure(code: AuthFailureCode.locked),
      ];

      expect(failures.map(failureType), [
        FailureType.validation,
        FailureType.network,
        FailureType.storage,
        FailureType.notFound,
        FailureType.unexpected,
        FailureType.conflict,
        FailureType.auth,
        FailureType.auth,
        FailureType.auth,
      ]);
    });

    test('auth failure code participates in equality', () {
      expect(
        const AuthFailure(code: AuthFailureCode.wrongOtp),
        isNot(const AuthFailure(code: AuthFailureCode.locked)),
      );
    });
  });

  test('sealed results support exhaustive switches and fold', () {
    const success = Success<int>(7);
    const failure = FailureResult<int>(NetworkFailure());

    expect(describeIntResult(success), 'success:7');
    expect(describeIntResult(failure), 'failure:network');
    expect(success.fold(onSuccess: (value) => value, onFailure: (_) => -1), 7);
    expect(failure.fold(onSuccess: (value) => value, onFailure: (_) => -1), -1);
  });

  test('combineWith transforms two successful results', () {
    final combined = const Success<int>(2).combineWith(
      const Success<String>(' donuts'),
      (count, label) => '$count$label',
    );

    expect(combined, const Success<String>('2 donuts'));
  });

  test('combineWith preserves a failure without invoking the transform', () {
    var transformed = false;
    final combined = const FailureResult<int>(StorageFailure())
        .combineWith(const Success<String>('unused'), (count, label) {
          transformed = true;
          return '$count$label';
        });

    expect(combined, const FailureResult<String>(StorageFailure()));
    expect(transformed, isFalse);
  });
}
