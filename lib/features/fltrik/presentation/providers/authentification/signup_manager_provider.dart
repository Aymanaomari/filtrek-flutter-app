import 'package:flutter/material.dart';

class LoginScreenState {
  final bool isLoading;
  final String? errorMessage;
  final bool isLoggedIn;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  LoginScreenState({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
    this.errorMessage,
    required this.isLoggedIn,
  });

  LoginScreenState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isLoggedIn,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    GlobalKey<FormState>? formKey,
  }) {
    return LoginScreenState(
      formKey: formKey ?? this.formKey,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}
