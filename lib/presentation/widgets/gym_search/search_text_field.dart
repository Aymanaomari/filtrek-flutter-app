import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? errorText;
  final bool readOnly;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;

  const SearchTextField({
    super.key,
    required this.hintText,
    required this.keyboardType,
    this.controller,
    this.validator,
    this.errorText,
    this.readOnly = false,
    this.onTap,
    this.focusNode,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // Reusable border radius & constant borders
    const borderRadius = BorderRadius.all(Radius.circular(100));
    const transparentBorderSide =
        BorderSide(color: Colors.transparent, width: 0);
    const baseOutlineBorder = OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: transparentBorderSide,
    );

    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.search,
      maxLines: 1,
      autocorrect: false,
      readOnly: readOnly,
      onTap: onTap,
      focusNode: focusNode,
      onChanged: onChanged,
      style: AppTypography.body1.copyWith(color: colors.onSurface),
      decoration: InputDecoration(
        filled: true,
        fillColor: colors.outline.withOpacity(0.2),
        border: baseOutlineBorder,
        enabledBorder: baseOutlineBorder,
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: colors.primary, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: colors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
        suffixIcon: Icon(Icons.search, color: colors.onSecondary),
        hintText: hintText,
        hintStyle: AppTypography.buttonText
            .copyWith(color: colors.outline, fontWeight: FontWeight.w400),
        floatingLabelStyle: AppTypography.body2.copyWith(color: colors.primary),
        errorText: errorText,
      ),
    );
  }
}
