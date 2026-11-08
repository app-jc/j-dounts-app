part of 'result.dart';

enum FailureType {
  validation,
  network,
  storage,
  notFound,
  unexpected,
  conflict,
  auth,
}

enum ConflictFailureCode { duplicatePhone }

enum AuthFailureCode { notRegistered, wrongOtp, locked }

sealed class Failure extends Equatable {
  const Failure({required this.type, this.cause});

  final FailureType type;
  final Object? cause;

  @override
  List<Object?> get props => [type];
}

final class ValidationFailure extends Failure {
  const ValidationFailure({super.cause}) : super(type: FailureType.validation);
}

final class NetworkFailure extends Failure {
  const NetworkFailure({super.cause}) : super(type: FailureType.network);
}

final class StorageFailure extends Failure {
  const StorageFailure({super.cause}) : super(type: FailureType.storage);
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure({super.cause}) : super(type: FailureType.notFound);
}

final class UnexpectedFailure extends Failure {
  const UnexpectedFailure({super.cause}) : super(type: FailureType.unexpected);
}

final class ConflictFailure extends Failure {
  const ConflictFailure({required this.code, super.cause})
    : super(type: FailureType.conflict);

  final ConflictFailureCode code;

  @override
  List<Object?> get props => [...super.props, code];
}

final class AuthFailure extends Failure {
  const AuthFailure({required this.code, super.cause})
    : super(type: FailureType.auth);

  final AuthFailureCode code;

  @override
  List<Object?> get props => [...super.props, code];
}
