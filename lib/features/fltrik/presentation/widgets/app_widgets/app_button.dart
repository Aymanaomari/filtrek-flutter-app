import 'package:filtrek_app/features/fltrik/core/constant/colors_assets.dart';
import 'package:filtrek_app/features/fltrik/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color backgroundColor;
  final double borderRadius;

  const AppButton({
    super.key,
    this.onPressed,
    required this.text,
    this.backgroundColor = ColorsAssets.primaryColor,
    this.borderRadius = 100,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: AppTypography.buttonText.copyWith(
            color: ColorsAssets.secondaryColor,
          ),
        ),
      ),
    );
  }
}
