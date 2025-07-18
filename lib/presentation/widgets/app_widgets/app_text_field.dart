import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// A reusable text field widget for forms and input fields.
///
/// This widget provides a customizable text field with the following features:
/// - A label text to guide the user on what to input.
/// - An optional icon displayed as a prefix inside the text field.
/// - Configurable keyboard type for different input types (e.g., text, email, number).
/// - A maximum character length to limit user input.
///
/// Parameters:
/// - [labelText]: The text displayed as the label of the field.
/// - [icon]: The optional icon displayed at the start of the text field.
/// - [showIcon]: Whether to show the icon (default is true). If false, icon won't be displayed even if provided.
/// - [keyboardType]: The type of keyboard to use for input (default is [TextInputType.text]).
///
/// Example usage:
/// ```dart
/// AppTextField(
///   labelText: 'Enter your email',
///   icon: Icons.email,
///   showIcon: true, // Controls icon visibility
///   keyboardType: TextInputType.emailAddress,
/// )
/// ```
class AppTextField extends StatelessWidget {
  final String labelText;
  final IconData? icon;
  final bool showIcon;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? errorText;
  final bool isError;

  const AppTextField({
    super.key,
    required this.labelText,
    this.icon,
    this.showIcon = true,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
    this.errorText,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return TextFormField(
      controller: controller, // Pass controller to TextFormField
      style: AppTypography.body1.copyWith(color: colors.onSurface),
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: colors.secondary,
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
          borderSide: BorderSide(
              color: isError ? colors.error : colors.primary, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colors.error, width: 2.0),
        ),
        prefixIcon: showIcon && icon != null
            ? Icon(
                icon,
                color: colors.primary,
              )
            : null,
        labelText: labelText,
        labelStyle: AppTypography.body2.copyWith(color: colors.outline),
        errorText: errorText,
      ),
    );
  }
}
