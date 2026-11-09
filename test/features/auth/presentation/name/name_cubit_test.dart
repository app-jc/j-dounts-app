import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/features/auth/presentation/name/name_cubit.dart';

void main() {
  test('validates required first name and optional last name', () {
    final cubit = NameCubit();
    addTearDown(cubit.close);

    cubit.updateFirstName('မောင်');
    cubit.updateLastName('');
    cubit.validate();

    expect(cubit.state.isValid, isTrue);
    expect(cubit.state.status, NameStatus.valid);
  });

  test('rejects digits and punctuation', () {
    final cubit = NameCubit();
    addTearDown(cubit.close);

    cubit.updateFirstName('Aung2');
    cubit.validate();

    expect(cubit.state.isValid, isFalse);
    expect(cubit.state.status, NameStatus.idle);
    expect(cubit.state.hasBlurred, isTrue);
  });
}
