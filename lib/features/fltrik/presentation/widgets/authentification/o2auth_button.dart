import 'package:filtrek_app/features/fltrik/core/constant/colors_assets.dart';
import 'package:filtrek_app/features/fltrik/core/constant/image_assets.dart';
import 'package:filtrek_app/features/fltrik/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GoogleO2authButton extends StatelessWidget {
  final void Function()? onPressed;
  final double borderRadius;

  const GoogleO2authButton(
      {super.key, this.onPressed, required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 12,
        children: [
          Image.asset(
            ImageAssets.googleIcon,
            height: 32,
            width: 32,
          ),
          Text(
            "Sign In with Google",
            style: AppTypography.button.copyWith(
              color: ColorsAssets.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
