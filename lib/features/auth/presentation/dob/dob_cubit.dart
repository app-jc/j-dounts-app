import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/core/time/clock.dart';
import 'package:j_dounts_app/features/auth/domain/auth_identity.dart';
import 'package:j_dounts_app/features/auth/domain/auth_repository.dart';
import 'package:j_dounts_app/features/auth/domain/validators/auth_validators.dart';

enum DobStatus { idle, submitting, submitted }

final class DobState extends Equatable {
  const DobState({
    this.year,
    this.month,
    this.day,
    this.status = DobStatus.idle,
    this.failure,
  });

  final int? year;
  final int? month;
  final int? day;
  final DobStatus status;
  final Failure? failure;

  DateTime? get date => year != null && month != null && day != null
      ? DateTime(year!, month!, day!)
      : null;

  bool isValid(Clock clock) =>
      year != null &&
      month != null &&
      day != null &&
      isValidDateOfBirth(year: year!, month: month!, day: day!, clock: clock);

  DobState copyWith({
    int? year,
    int? month,
    int? day,
    DobStatus? status,
    Failure? failure,
    bool clearFailure = false,
  }) => DobState(
    year: year ?? this.year,
    month: month ?? this.month,
    day: day ?? this.day,
    status: status ?? this.status,
    failure: clearFailure ? null : failure ?? this.failure,
  );

  @override
  List<Object?> get props => [year, month, day, status, failure];
}

final class DobCubit extends Cubit<DobState> {
  DobCubit(
    this._authRepository, {
    required this.phone,
    required this.firstName,
    required this.lastName,
    Clock? clock,
  }) : _clock = clock ?? const SystemClock(),
       super(const DobState());

  final AuthRepository _authRepository;
  final String phone;
  final String firstName;
  final String? lastName;
  final Clock _clock;
  bool _isSubmitting = false;

  void select({int? year, int? month, int? day}) => emit(
    state.copyWith(
      year: year,
      month: month,
      day: day,
      status: DobStatus.idle,
      clearFailure: true,
    ),
  );

  Future<AuthIdentity?> submit() async {
    if (_isSubmitting) return null;
    if (!state.isValid(_clock)) {
      emit(state.copyWith(failure: const ValidationFailure()));
      return null;
    }
    _isSubmitting = true;
    emit(state.copyWith(status: DobStatus.submitting, clearFailure: true));
    final result = await _authRepository.registerMember(
      phone: phone,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: state.date!,
    );
    return result.fold(
      onSuccess: (identity) {
        _isSubmitting = false;
        emit(state.copyWith(status: DobStatus.submitted));
        return identity;
      },
      onFailure: (failure) {
        _isSubmitting = false;
        emit(state.copyWith(status: DobStatus.idle, failure: failure));
        return null;
      },
    );
  }
}
