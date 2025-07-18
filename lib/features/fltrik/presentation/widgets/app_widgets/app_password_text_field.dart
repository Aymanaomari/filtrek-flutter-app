import 'package:filtrek_app/features/fltrik/core/constant/colors_assets.dart';
import 'package:filtrek_app/features/fltrik/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// A password text field widget with show/hide functionality for secure input.
///
/// This widget is designed for password entry in forms. It provides:
/// - A label to describe the field's purpose.
/// - An icon displayed as a prefix inside the text field.
/// - Configurable keyboard type (default is [TextInputType.text]).
/// - A [TextEditingController] to manage the input text.
/// - An optional validator for form validation.
/// - An optional [obscure] property to set the initial visibility of the password.
/// - A suffix icon button to toggle password visibility (show/hide password).
///
/// Parameters:
/// - [labelText]: The label displayed above the text field.
/// - [icon]: The icon displayed at the start of the text field.
/// - [keyboardType]: The type of keyboard to use for input.
/// - [controller]: Controls the text being edited.
/// - [validator]: Optional form field validator.
/// - [obscure]: Whether the password is initially hidden (default: false).
///
/// Example usage:
/// ```dart
/// AppPasswordTextField(
///   labelText: 'New password',
///   icon: Icons.lock_outline,
///   controller: passwordController,
///   validator: (value) => value != null && value.length < 6
///       ? 'Password must be at least 6 characters'
///       : null,
/// )
/// ```

class AppPasswordTextField extends StatefulWidget {
  final String labelText;
  final IconData icon;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscure;
  final String? errorText;

  const AppPasswordTextField({
    super.key,
    required this.labelText,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
    this.obscure = false,
    this.errorText,
  });

  @override
  _AppPasswordTextFieldState createState() => _AppPasswordTextFieldState();
}

class _AppPasswordTextFieldState extends State<AppPasswordTextField> {
  late bool isObscure;

  @override
  void initState() {
    super.initState();
    isObscure = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: AppTypography.body1.copyWith(color: ColorsAssets.textLight),
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      obscureText: isObscure,
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
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        suffixIcon: IconButton(
          icon: Icon(
            isObscure
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: ColorsAssets.primaryColor,
          ),
          onPressed: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
        ),
        labelText: widget.labelText,
        labelStyle:
            AppTypography.body2.copyWith(color: ColorsAssets.textLightMedium),
        errorText: widget.errorText,
      ),
    );
  }
}
