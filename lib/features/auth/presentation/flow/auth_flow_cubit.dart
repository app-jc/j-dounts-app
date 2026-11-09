import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthFlowType { registration, login }

enum AuthFlowStep { phone, otp, name, dateOfBirth, welcome }

final class AuthDraft extends Equatable {
  const AuthDraft({
    this.phone = '',
    this.firstName = '',
    this.lastName,
    this.dateOfBirth,
  });

  final String phone;
  final String firstName;
  final String? lastName;
  final DateTime? dateOfBirth;

  AuthDraft copyWith({
    String? phone,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    bool clearLastName = false,
    bool clearDateOfBirth = false,
  }) => AuthDraft(
    phone: phone ?? this.phone,
    firstName: firstName ?? this.firstName,
    lastName: clearLastName ? null : lastName ?? this.lastName,
    dateOfBirth: clearDateOfBirth ? null : dateOfBirth ?? this.dateOfBirth,
  );

  @override
  List<Object?> get props => [phone, firstName, lastName, dateOfBirth];
}

final class AuthFlowState extends Equatable {
  const AuthFlowState({
    this.flow,
    this.step = AuthFlowStep.phone,
    this.draft = const AuthDraft(),
  });

  final AuthFlowType? flow;
  final AuthFlowStep step;
  final AuthDraft draft;

  AuthFlowState copyWith({
    AuthFlowType? flow,
    AuthFlowStep? step,
    AuthDraft? draft,
    bool clearFlow = false,
  }) => AuthFlowState(
    flow: clearFlow ? null : flow ?? this.flow,
    step: step ?? this.step,
    draft: draft ?? this.draft,
  );

  @override
  List<Object?> get props => [flow, step, draft];
}

final class AuthFlowCubit extends Cubit<AuthFlowState> {
  AuthFlowCubit() : super(const AuthFlowState());

  void startRegistration() => _start(AuthFlowType.registration);

  void startLogin() => _start(AuthFlowType.login);

  void updatePhone(String phone) {
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
          clearDateOfBirth: dateOfBirth == null,
        ),
      ),
    );
  }

  void setStep(AuthFlowStep step) => emit(state.copyWith(step: step));

  void reset() => emit(const AuthFlowState());

  void _start(AuthFlowType flow) {
    emit(AuthFlowState(flow: flow));
  }
}
