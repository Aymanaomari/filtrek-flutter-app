import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:phone_text_field/phone_text_field.dart';

/// A reusable phone text field widget for forms and input fields.
///
/// This widget provides a customizable phone text field with the following features:
/// - A hint text to guide the user on what to input.
/// - An icon displayed as a prefix inside the text field.
/// - Country code selection with search functionality.
/// - Phone number validation and formatting.
/// - Controller-like functionality to access phone number data.
///
/// Parameters:
/// - [hintText]: The placeholder text displayed when the field is empty.
/// - [icon]: The icon displayed at the start of the text field.
/// - [controller]: A ValueNotifier to access the current phone number data.
/// - [onChanged]: Callback function called when the phone number changes.
/// - [initialCountryCode]: The initial country code (default is "AE").
///
/// Example usage:
/// ```dart
/// final phoneController = ValueNotifier<PhoneNumber?>(null);
///
/// AppPhoneTextField(
///   hintText: 'Enter your phone number',
///   icon: Icons.phone,
///   controller: phoneController,
///   initialCountryCode: "AE",
///   onChanged: (phone) {
///     print('Phone: ${phone.completeNumber}');
///   },
/// )
///
/// // To get the phone number in your manager:
/// String? phoneNumber = phoneController.value?.completeNumber;
/// ```
class AppPhoneTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final String? errorText;
  final void Function(PhoneNumber)? onChanged;
  final String? initialCountryCode;
  final ValueNotifier<PhoneNumber?>? controller;

  const AppPhoneTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.errorText,
    this.onChanged,
    this.initialCountryCode = "MA",
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isError = errorText != null && errorText!.isNotEmpty;

    return PhoneTextField(
      autovalidateMode: AutovalidateMode.disabled,
      locale: const Locale('en'),
      initialValue: controller != null && controller!.value != null
          ? controller!.value!.completeNumber
          : null,
      decoration: InputDecoration(
          filled: true,
          fillColor: colors.secondary,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: isError ? colors.error : Colors.transparent, width: 0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: isError ? colors.error : Colors.transparent, width: 0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: isError ? colors.error : colors.primary, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colors.error),
          ),
          prefixIcon: Icon(
            icon,
            color: colors.primary,
          ),
          labelText: hintText,
          labelStyle: AppTypography.body2.copyWith(color: colors.outline),
          errorText: errorText,
          errorMaxLines: 2),
      searchFieldInputDecoration: InputDecoration(
          filled: true,
          fillColor: colors.secondary,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colors.primary, width: 2.0),
          ),
          suffixIcon: Icon(
            Icons.search,
            color: colors.primary,
          ),
          hintText: "Search country",
          hintStyle: AppTypography.body2.copyWith(color: colors.outline),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: colors.error))),
      initialCountryCode: initialCountryCode,
      onChanged: (phone) {
        // Update controller if provided
        controller?.value = phone;
        // Call the onChanged callback if provided
        onChanged?.call(phone);
      },
    );
  }
}
