import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:j_dounts_app/app/router/app_routes.dart';
import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/app/theme/app_typography.dart';
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
              onTap: () => _pickMonth(context, state.month),
            ),
            _DateField(
              label: state.day?.toString() ?? localizations.day,
              onTap: () => _pickDay(context, state.day),
            ),
            _DateField(
              label: state.year?.toString() ?? localizations.year,
              onTap: () => _pickYear(context, state.year),
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

  Future<void> _pickMonth(BuildContext context, int? selected) async {
    final value = await _pick(context, 12, selected ?? 1);
    if (value != null && context.mounted) {
      context.read<DobCubit>().select(month: value);
    }
  }

  Future<void> _pickDay(BuildContext context, int? selected) async {
    final value = await _pick(context, 31, selected ?? 1);
    if (value != null && context.mounted) {
      context.read<DobCubit>().select(day: value);
    }
  }

  Future<void> _pickYear(BuildContext context, int? selected) async {
    final currentYear = DateTime.now().year;
    final value = await _pick(
      context,
      120,
      selected ?? currentYear - 13,
      offset: currentYear - 119,
    );
    if (value != null && context.mounted) {
      context.read<DobCubit>().select(year: value);
    }
  }

  Future<int?> _pick(
    BuildContext context,
    int count,
    int selected, {
    int offset = 1,
  }) => showModalBottomSheet<int>(
    context: context,
    builder: (context) => SizedBox(
      height: 240,
      child: CupertinoPicker(
        itemExtent: 44,
        scrollController: FixedExtentScrollController(
          initialItem: (selected - offset).clamp(0, count - 1),
        ),
        onSelectedItemChanged: (index) =>
            Navigator.of(context).pop(index + offset),
        children: [
          for (var index = 0; index < count; index++)
            Center(child: Text('${index + offset}')),
        ],
      ),
    ),
  );
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
