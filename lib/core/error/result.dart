import 'package:equatable/equatable.dart';

part 'failures.dart';

sealed class Result<T> extends Equatable {
  const Result();

  Result<R> combineWith<U, R>(
    Result<U> other,
    R Function(T value, U otherValue) combine,
  ) => fold(
    onFailure: FailureResult<R>.new,
    onSuccess: (value) => other.fold(
      onFailure: FailureResult<R>.new,
      onSuccess: (otherValue) => Success<R>(combine(value, otherValue)),
    ),
  );

  R fold<R>({
    required R Function(T value) onSuccess,
    required R Function(Failure failure) onFailure,
  }) => switch (this) {
    Success<T>(value: final value) => onSuccess(value),
    FailureResult<T>(failure: final failure) => onFailure(failure),
  };
}

final class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;

  @override
  List<Object?> get props => [value];
}

final class FailureResult<T> extends Result<T> {
  const FailureResult(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
