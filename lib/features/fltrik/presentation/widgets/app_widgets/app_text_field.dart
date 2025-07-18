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
 *
 * Example usage:
 * ```dart
 * AppTextField(
 *   hintText: 'Enter your email',
 *   icon: Icons.email,
 *   keyboardType: TextInputType.emailAddress,
 * )
 * ```
 */

class AppTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  // Add controller parameter

  const AppTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator, // Initialize controller
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // Pass controller to TextFormField
      style: AppTypography.body1.copyWith(color: ColorsAssets.textLight),
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorsAssets.thirdColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.transparent, width: 0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ColorsAssets.primaryColor, width: 2.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        prefixIcon: Icon(
          icon,
          color: ColorsAssets.primaryColor,
        ),
        hintText: hintText,
        hintStyle:
            AppTypography.body2.copyWith(color: ColorsAssets.textLightMedium),
      ),
    );
  }
}
