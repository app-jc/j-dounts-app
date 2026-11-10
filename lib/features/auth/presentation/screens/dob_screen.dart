import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:j_dounts_app/app/router/app_routes.dart';
import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/app/theme/app_typography.dart';
import 'package:j_dounts_app/features/auth/domain/validators/auth_validators.dart';
import 'package:j_dounts_app/features/auth/presentation/dob/dob_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/flow/auth_flow_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

class DobScreen extends StatelessWidget {
  const DobScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<DobCubit, DobState>(
    builder: (context, state) {
      final localizations = AppLocalizations.of(context);
      final locale = Localizations.localeOf(context).toLanguageTag();
      return AuthScaffold(
        title: localizations.dobTitle,
        progressStep: 4,
        progressLabel: localizations.dobTitle,
        isComplete: state.status == DobStatus.submitted,
        isLoading: state.status == DobStatus.submitting,
        onBack: () =>
            context.canPop() ? context.pop() : context.go(AppRoutes.name),
        onContinue: state.status == DobStatus.submitting
            ? null
            : () => _submit(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DateField(
              label: state.month == null
                  ? localizations.month
                  : DateFormat.MMMM(locale)
                        .format(DateTime(2000, state.month!)),
              onTap: () => _pickDate(context, state),
            ),
            _DateField(
              label: state.day?.toString() ?? localizations.day,
              onTap: () => _pickDate(context, state),
            ),
            _DateField(
              label: state.year?.toString() ?? localizations.year,
              onTap: () => _pickDate(context, state),
            ),
            if (state.failure != null)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sm),
                child: Text(
                  localizations.dobInvalid,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
          ],
        ),
      );
    },
  );

  Future<void> _submit(BuildContext context) async {
    final identity = await context.read<DobCubit>().submit();
    if (identity == null || !context.mounted) return;
    context.read<AuthFlowCubit>().setStep(AuthFlowStep.welcome);
    context.go(AppRoutes.welcome, extra: identity.memberId);
  }

  Future<void> _pickDate(BuildContext context, DobState state) async {
    final today = context.read<DobCubit>().today;
    final existing = state.date;
    final initial =
        existing != null &&
            existing.year == state.year &&
            existing.month == state.month &&
            existing.day == state.day &&
            existing.year >= today.year - 119 &&
            existing.year <= today.year
        ? existing
        : DateTime(today.year - minimumAge);
    var selected = initial;
    final date = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(sheetContext),
                  child: Text(
                    MaterialLocalizations.of(sheetContext).cancelButtonLabel,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(sheetContext, selected),
                  child: Text(
                    MaterialLocalizations.of(sheetContext).okButtonLabel,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 240,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                dateOrder: DatePickerDateOrder.mdy,
                initialDateTime: initial,
                minimumYear: today.year - 119,
                maximumYear: today.year,
                onDateTimeChanged: (date) => selected = date,
              ),
            ),
          ],
        ),
      ),
    );
    if (date == null || !context.mounted) return;
    context.read<DobCubit>().select(
      year: date.year,
      month: date.month,
      day: date.day,
    );
    context.read<AuthFlowCubit>().updateRawDateOfBirth(
      year: date.year.toString(),
      month: date.month.toString(),
      day: date.day.toString(),
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpacing.md),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.fieldRadius),
      child: Container(
        height: AppSpacing.fieldHeight,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceCard,
          borderRadius: BorderRadius.circular(AppSpacing.fieldRadius),
        ),
        alignment: Alignment.centerLeft,
        child: Text(label, style: AppTypography.fieldText),
      ),
    ),
  );
}
