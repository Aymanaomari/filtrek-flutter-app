import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;
  final Widget? child;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final double height;

  const AppButton({
    super.key,
    this.onPressed,
    this.text,
    this.child,
    this.borderRadius = 100,
    this.backgroundColor,
    this.textColor,
    this.height = 56,
  }) : assert(text != null || child != null,
            'Either text or child must be provided');

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    // Use provided colors or fall back to theme colors
    final bgColor = backgroundColor ?? color.primary;
    final txtColor = textColor ?? color.onPrimary;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: txtColor,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: child ??
            Text(
              text!,
              style: AppTypography.buttonText.copyWith(
                color: txtColor,
              ),
            ),
      ),
    );
  }
}
