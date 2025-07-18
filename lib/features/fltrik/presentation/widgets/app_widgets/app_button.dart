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
    return MaterialButton(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: AppTypography.button.copyWith(
          color: ColorsAssets.secondaryColor,
        ),
      ),
    );
  }
}
