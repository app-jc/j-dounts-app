import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/features/auth/presentation/flow/auth_flow_cubit.dart';

void main() {
  test('entry points set their flow and reset the draft', () async {
    final cubit = AuthFlowCubit();
    addTearDown(cubit.close);

    cubit.startRegistration();
    expect(cubit.state.flow, AuthFlowType.registration);

    cubit.updatePhone('+95912345678');
    cubit.setStep(AuthFlowStep.otp);
    cubit.startLogin();

    expect(cubit.state.flow, AuthFlowType.login);
    expect(cubit.state.step, AuthFlowStep.phone);
    expect(cubit.state.draft, const AuthDraft());
  });
}
