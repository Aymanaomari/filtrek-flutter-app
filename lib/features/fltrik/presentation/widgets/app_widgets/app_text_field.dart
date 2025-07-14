import 'package:filtrek_app/features/fltrik/core/constant/colors_assets.dart';
import 'package:filtrek_app/features/fltrik/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/**
 * A reusable text field widget for forms and input fields.
 *
 * This widget provides a customizable text field with the following features:
 * - A hint text to guide the user on what to input.
 * - An icon displayed as a prefix inside the text field.
 * - Configurable keyboard type for different input types (e.g., text, email, number).
 * - A maximum character length to limit user input.
 *
 * Parameters:
 * - [hintText]: The placeholder text displayed when the field is empty.
 * - [icon]: The icon displayed at the start of the text field.
 * - [keyboardType]: The type of keyboard to use for input (default is [TextInputType.text]).
 * - [maxLength]: The maximum number of characters allowed (default is 100).
 *
 * Example usage:
 * ```dart
 * AppTextField(
 *   hintText: 'Enter your email',
 *   icon: Icons.email,
 *   keyboardType: TextInputType.emailAddress,
 *   maxLength: 50,
 * )
 * ```
 */
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
