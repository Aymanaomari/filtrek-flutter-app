import 'package:filtrek_app/features/fltrik/core/constant/colors_assets.dart';
import 'package:filtrek_app/features/fltrik/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTypography.body1.copyWith(color: ColorsAssets.textLight),
      decoration: InputDecoration(
          filled: true,
          fillColor: ColorsAssets.thirdColor,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(width: 0)),
          prefixIcon: Icon(
            Icons.message,
            color: ColorsAssets.primaryColor,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: ColorsAssets.primaryColor)),
          enabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          hintText: "Enter Your email",
          hintStyle: AppTypography.body2
              .copyWith(color: ColorsAssets.textLightMedium)),
    );
  }
}
