import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:j_dounts_app/core/time/clock.dart';
import 'package:j_dounts_app/features/auth/domain/otp_state_machine.dart';

enum AuthFlowType { registration, login }

enum AuthFlowStep { phone, otp, name, dateOfBirth, welcome }

final class AuthDraft extends Equatable {
  const AuthDraft({
    this.phone = '',
    this.rawPhone = '',
    this.firstName = '',
    this.lastName,
    this.dateOfBirth,
    this.rawDobDay = '',
    this.rawDobMonth = '',
    this.rawDobYear = '',
  });

  final String phone;
  final String rawPhone;
  final String firstName;
  final String? lastName;
  final DateTime? dateOfBirth;
  final String rawDobDay;
  final String rawDobMonth;
  final String rawDobYear;

  AuthDraft copyWith({
    String? phone,
    String? rawPhone,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    bool clearLastName = false,
    bool clearDateOfBirth = false,
    String? rawDobDay,
    String? rawDobMonth,
    String? rawDobYear,
  }) => AuthDraft(
    phone: phone ?? this.phone,
    rawPhone: rawPhone ?? this.rawPhone,
    firstName: firstName ?? this.firstName,
    lastName: clearLastName ? null : lastName ?? this.lastName,
    dateOfBirth: clearDateOfBirth ? null : dateOfBirth ?? this.dateOfBirth,
    rawDobDay: rawDobDay ?? this.rawDobDay,
    rawDobMonth: rawDobMonth ?? this.rawDobMonth,
    rawDobYear: rawDobYear ?? this.rawDobYear,
  );

  @override
  List<Object?> get props => [
    phone,
    rawPhone,
    firstName,
    lastName,
    dateOfBirth,
    rawDobDay,
    rawDobMonth,
    rawDobYear,
  ];
}

final class AuthOtpSession extends Equatable {
  const AuthOtpSession({
    required this.phone,
    required this.resendDeadline,
    this.wrongAttempts = 0,
    this.isLocked = false,
    this.isVerified = false,
  });

  final String phone;
  final DateTime resendDeadline;
  final int wrongAttempts;
  final bool isLocked;
  final bool isVerified;

  AuthOtpSession copyWith({
    DateTime? resendDeadline,
    int? wrongAttempts,
    bool? isLocked,
    bool? isVerified,
  }) => AuthOtpSession(
    phone: phone,
    resendDeadline: resendDeadline ?? this.resendDeadline,
    wrongAttempts: wrongAttempts ?? this.wrongAttempts,
    isLocked: isLocked ?? this.isLocked,
    isVerified: isVerified ?? this.isVerified,
  );

  @override
  List<Object?> get props => [
    phone,
    resendDeadline,
    wrongAttempts,
    isLocked,
    isVerified,
  ];
}

final class AuthFlowState extends Equatable {
  const AuthFlowState({
    this.flow,
    this.step = AuthFlowStep.phone,
    this.draft = const AuthDraft(),
    this.otpSession,
    this.isSubmitting = false,
  });

  final AuthFlowType? flow;
  final AuthFlowStep step;
  final AuthDraft draft;
  final AuthOtpSession? otpSession;
  final bool isSubmitting;

  AuthFlowState copyWith({
    AuthFlowType? flow,
    AuthFlowStep? step,
    AuthDraft? draft,
    bool clearFlow = false,
    AuthOtpSession? otpSession,
    bool clearOtpSession = false,
    bool? isSubmitting,
  }) => AuthFlowState(
    flow: clearFlow ? null : flow ?? this.flow,
    step: step ?? this.step,
    draft: draft ?? this.draft,
    otpSession: clearOtpSession ? null : otpSession ?? this.otpSession,
    isSubmitting: isSubmitting ?? this.isSubmitting,
  );

  @override
  List<Object?> get props => [flow, step, draft, otpSession, isSubmitting];
}

final class AuthFlowCubit extends Cubit<AuthFlowState> {
  AuthFlowCubit() : super(const AuthFlowState());

  void startRegistration() => _start(AuthFlowType.registration);

  void startLogin() => _start(AuthFlowType.login);

  void updatePhone(String phone) {
    final phoneChanged = state.draft.rawPhone != phone;
    emit(
      state.copyWith(
        draft: state.draft.copyWith(phone: phone, rawPhone: phone),
        clearOtpSession: phoneChanged,
      ),
    );
  }

  void updateCanonicalPhone(String phone) {
    emit(state.copyWith(draft: state.draft.copyWith(phone: phone)));
  }

  void updateName({required String firstName, required String? lastName}) {
    emit(
      state.copyWith(
        draft: state.draft.copyWith(
          firstName: firstName,
          lastName: lastName,
          clearLastName: lastName == null,
        ),
      ),
    );
  }

  void updateDateOfBirth(DateTime? dateOfBirth) {
    emit(
      state.copyWith(
        draft: state.draft.copyWith(
          dateOfBirth: dateOfBirth,
          rawDobDay: dateOfBirth?.day.toString() ?? '',
          rawDobMonth: dateOfBirth?.month.toString() ?? '',
          rawDobYear: dateOfBirth?.year.toString() ?? '',
          clearDateOfBirth: dateOfBirth == null,
        ),
      ),
    );
  }

  void updateRawDateOfBirth({String? day, String? month, String? year}) {
    emit(
      state.copyWith(
        draft: state.draft.copyWith(
          rawDobDay: day,
          rawDobMonth: month,
          rawDobYear: year,
        ),
      ),
    );
  }

  void setStep(AuthFlowStep step) => emit(state.copyWith(step: step));

  void beginOtp(String phone, Clock clock) {
    if (state.otpSession?.phone == phone) return;
    emit(
      state.copyWith(
        otpSession: AuthOtpSession(
          phone: phone,
          resendDeadline: clock.now().add(const Duration(minutes: 5)),
        ),
      ),
    );
  }

  void markOtpVerified() {
    final session = state.otpSession;
    if (session == null) return;
    emit(state.copyWith(otpSession: session.copyWith(isVerified: true)));
  }

  void updateOtpAttempt(OtpAttemptState attempt) {
    final session = state.otpSession;
    if (session == null) return;
    emit(
      state.copyWith(
        otpSession: session.copyWith(
          resendDeadline: attempt.resendDeadline,
          wrongAttempts: attempt.wrongAttempts,
          isLocked: attempt.isLocked,
        ),
      ),
    );
  }

  void setSubmitting(bool value) => emit(state.copyWith(isSubmitting: value));

  void clearOtpSession() => emit(state.copyWith(clearOtpSession: true));

  void reset() => emit(const AuthFlowState());

  void _start(AuthFlowType flow) {
    emit(AuthFlowState(flow: flow));
  }
}
