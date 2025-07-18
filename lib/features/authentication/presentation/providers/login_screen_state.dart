import 'package:flutter/material.dart';
import 'package:phone_text_field/model/phone_number.dart';

class LoginScreenState {
  final bool isLoading;
  final String? errorMessage;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final bool emailError;
  final bool passwordError;
  final ValueNotifier<PhoneNumber?> phoneController;

  LoginScreenState({
    required this.formKey,
    required this.passwordController,
    required this.phoneController,
    required this.isLoading,
    this.errorMessage,
    this.emailError = false,
    this.passwordError = false,
  });

  LoginScreenState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isLoggedIn,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    GlobalKey<FormState>? formKey,
    ValueNotifier<PhoneNumber?>? phoneController,
    bool? emailError,
    bool? passwordError,
  }) {
    return LoginScreenState(
      formKey: formKey ?? this.formKey,
      passwordController: passwordController ?? this.passwordController,
      phoneController: phoneController ?? this.phoneController,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
    );
  }
}
