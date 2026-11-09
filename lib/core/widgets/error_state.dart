import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';

import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

class ErrorState extends StatefulWidget {
  const ErrorState({required this.onRetry, super.key});

  final Future<void> Function() onRetry;

  @override
  State<ErrorState> createState() => _ErrorStateState();
}

class _ErrorStateState extends State<ErrorState> {
  static const double _iconSize = 48;

  bool _isRetrying = false;

  Future<void> _retry() async {
    setState(() => _isRetrying = true);
    try {
      await widget.onRetry();
    } on Exception catch (error, stackTrace) {
      developer.log(
        'Database seed retry failed.',
        name: 'bootstrap',
        error: error,
        stackTrace: stackTrace,
      );
    } finally {
      if (mounted) setState(() => _isRetrying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: theme.colorScheme.error,
                    size: _iconSize,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    localizations.seedFailureTitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    localizations.seedFailureMessage,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  FilledButton(
                    onPressed: _isRetrying ? null : () => unawaited(_retry()),
                    child: _retryingButton(localizations),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _retryingButton(AppLocalizations localizations) {
    if (!_isRetrying) return Text(localizations.retry);
    return Semantics(
      label: localizations.retry,
      child: const SizedBox.square(
        dimension: AppSpacing.md + AppSpacing.sm,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}
