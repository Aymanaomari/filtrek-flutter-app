import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class AppButtonTwo extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final double borderRadius;

  AppButtonTwo({
    super.key,
    this.onPressed,
    required this.text,
    this.borderRadius = 30,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: AppTypography.buttonText.copyWith(
            color: color.primary,
          ),
        ),
      ),
    );
  }
}
