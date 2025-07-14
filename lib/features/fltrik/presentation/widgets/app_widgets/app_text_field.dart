import 'package:filtrek_app/features/fltrik/core/constant/colors_assets.dart';
import 'package:filtrek_app/features/fltrik/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;
  final int maxLength;

  const AppTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.maxLength = 100,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTypography.body1.copyWith(color: ColorsAssets.textLight),
      keyboardType: keyboardType,
      maxLength: maxLength,
      decoration: InputDecoration(
          filled: true,
          fillColor: ColorsAssets.thirdColor,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(width: 0)),
          prefixIcon: Icon(
            icon,
            color: ColorsAssets.primaryColor,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: ColorsAssets.primaryColor)),
          enabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          hintText: hintText,
          hintStyle: AppTypography.body2
              .copyWith(color: ColorsAssets.textLightMedium)),
    );
  }
}
