import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/features/auth/domain/validators/auth_validators.dart'
    as validators;

enum NameStatus { idle, valid }

final class NameState extends Equatable {
  const NameState({
    this.firstName = '',
    this.lastName = '',
    this.status = NameStatus.idle,
    this.hasBlurred = false,
  });

  final String firstName;
  final String lastName;
  final NameStatus status;
  final bool hasBlurred;

  bool get isValid =>
      validators.isValidFirstName(firstName) &&
      validators.isValidLastName(lastName);

  NameState copyWith({
    String? firstName,
    String? lastName,
    NameStatus? status,
    bool? hasBlurred,
  }) => NameState(
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    status: status ?? this.status,
    hasBlurred: hasBlurred ?? this.hasBlurred,
  );

  @override
  List<Object?> get props => [firstName, lastName, status, hasBlurred];
}

final class NameCubit extends Cubit<NameState> {
  NameCubit() : super(const NameState());

  void updateFirstName(String value) => _update(firstName: value);

  void updateLastName(String value) => _update(lastName: value);

  void markBlurred() {
    if (state.hasBlurred) return;
    emit(state.copyWith(hasBlurred: true));
  }

  void validate() {
    if (!state.isValid) {
      emit(state.copyWith(hasBlurred: true, status: NameStatus.idle));
      return;
    }
    emit(state.copyWith(status: NameStatus.valid));
  }

  Failure? failureFor(String value, {required bool required}) {
    final valid = required
        ? validators.isValidFirstName(value)
        : validators.isValidLastName(value);
    return valid ? null : const ValidationFailure();
  }

  void _update({String? firstName, String? lastName}) => emit(
    state.copyWith(
      firstName: firstName,
      lastName: lastName,
      status: NameStatus.idle,
    ),
  );
}
