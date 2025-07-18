import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinputWidget extends StatefulWidget {
  final void Function(String)? onCompleted;
  final bool isError;
  final FocusNode? focusNode;
  const PinputWidget(
      {super.key, this.onCompleted, this.isError = false, this.focusNode});

  @override
  State<PinputWidget> createState() => _PinputWidgetState();
}

class _PinputWidgetState extends State<PinputWidget> {
  late final TextEditingController _pinController;

  @override
  void initState() {
    super.initState();
    _pinController = TextEditingController();
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final defaultPinTheme = PinTheme(
      width: 74,
      height: 70,
      textStyle: AppTypography.bodyLarge
          .copyWith(color: colors.primary, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: colors.outlineVariant),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: colors.primary, width: 2),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration?.copyWith(
      border: Border.all(color: colors.primary, width: 2),
    ));

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        border: Border.all(color: colors.error, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    return Pinput(
      forceErrorState: widget.isError,
      controller: _pinController,
      focusNode: widget.focusNode,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      errorPinTheme: errorPinTheme,
      errorText: widget.isError ? 'Invalid  or Expired OTP' : null,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: widget.onCompleted,
    );
  }
}
