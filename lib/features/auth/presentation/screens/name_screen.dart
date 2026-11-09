import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:j_dounts_app/app/router/app_routes.dart';
import 'package:j_dounts_app/core/widgets/app_text_field.dart';
import 'package:j_dounts_app/features/auth/presentation/flow/auth_flow_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/name/name_cubit.dart';
import 'package:j_dounts_app/features/auth/domain/validators/auth_validators.dart';
import 'package:j_dounts_app/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  late final TextEditingController _firstName;
  late final TextEditingController _lastName;

  @override
  void initState() {
    super.initState();
    final draft = context.read<AuthFlowCubit>().state.draft;
    _firstName = TextEditingController(text: draft.firstName);
    _lastName = TextEditingController(text: draft.lastName ?? '');
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<NameCubit, NameState>(
    builder: (context, state) {
      final localizations = AppLocalizations.of(context);
      return AuthScaffold(
        title: localizations.nameTitle,
        progressStep: 3,
        progressLabel: localizations.nameTitle,
        onBack: () =>
            context.canPop() ? context.pop() : context.go(AppRoutes.phone),
        onContinue: state.isValid
            ? () {
                context.read<AuthFlowCubit>().updateName(
                  firstName: state.firstName.trim(),
                  lastName: state.lastName.trim().isEmpty
                      ? null
                      : state.lastName.trim(),
                );
                context.read<AuthFlowCubit>().setStep(AuthFlowStep.dateOfBirth);
                context.push(AppRoutes.dateOfBirth);
              }
            : () => context.read<NameCubit>().validate(),
        child: Column(
          children: [
            AppTextField(
              controller: _firstName,
              hintText: localizations.firstName,
              errorText: _nameError(
                localizations,
                state,
                state.firstName,
                required: true,
              ),
              textCapitalization: TextCapitalization.words,
              onChanged: context.read<NameCubit>().updateFirstName,
              onFocusChanged: (focused) {
                if (!focused) context.read<NameCubit>().markBlurred();
              },
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _lastName,
              hintText: localizations.lastName,
              errorText: _nameError(
                localizations,
                state,
                state.lastName,
                required: false,
              ),
              textCapitalization: TextCapitalization.words,
              onChanged: context.read<NameCubit>().updateLastName,
            ),
          ],
        ),
      );
    },
  );

  String? _nameError(
    AppLocalizations localizations,
    NameState state,
    String value, {
    required bool required,
  }) {
    if (!state.hasBlurred && state.status == NameStatus.idle) return null;
    if (required && !isValidFirstName(value)) {
      return localizations.firstNameInvalid;
    }
    if (!required && value.isNotEmpty && !isValidLastName(value)) {
      return localizations.lastNameInvalid;
    }
    return null;
  }
}
