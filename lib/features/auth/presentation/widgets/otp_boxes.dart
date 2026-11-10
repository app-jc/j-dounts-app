import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/app/theme/app_typography.dart';

class OtpBoxes extends StatefulWidget {
  const OtpBoxes({
    required this.value,
    required this.onChanged,
    this.shakeToken = 0,
    this.onSubmitted,
    super.key,
  });

  final String value;
  final ValueChanged<String> onChanged;
  final int shakeToken;
  final VoidCallback? onSubmitted;

  @override
  State<OtpBoxes> createState() => _OtpBoxesState();
}

class _OtpBoxesState extends State<OtpBoxes>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  late final AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _focusNode = FocusNode();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
  }

  @override
  void didUpdateWidget(covariant OtpBoxes oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_controller.text != widget.value) _controller.text = widget.value;
    if (oldWidget.shakeToken != widget.shakeToken) {
      _shakeController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _shakeController,
    builder: (context, child) => Transform.translate(
      offset: Offset(
        8 *
            (1 - _shakeController.value) *
            ((_shakeController.value * 8).floor().isEven ? 1 : -1),
        0,
      ),
      child: child,
    ),
    child: Semantics(
      textField: true,
      child: GestureDetector(
        onTap: _focusNode.requestFocus,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List<Widget>.generate(6, _buildBox),
            ),
            Positioned.fill(
              child: Opacity(
                opacity: 0,
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: _focusNode.unfocus,
                  onSubmitted: (_) => widget.onSubmitted?.call(),
                  autofillHints: const [AutofillHints.oneTimeCode],
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                  onChanged: widget.onChanged,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _buildBox(int index) {
    final character = index < widget.value.length ? widget.value[index] : '';
    return Container(
      width: AppSpacing.otpBoxWidth,
      height: AppSpacing.otpBoxHeight,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(AppSpacing.fieldRadius),
        border: Border.all(
          color: character.isEmpty ? AppColors.trackGrey : AppColors.actionBlue,
        ),
      ),
      child: Text(character, style: AppTypography.screenTitle),
    );
  }
}
