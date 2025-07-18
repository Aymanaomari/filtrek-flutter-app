import 'package:flutter/material.dart';

class EnterNewPasswordScreenState {
  final TextEditingController passwordTextController;
  final TextEditingController passwordConfirmController;
  final GlobalKey<FormState> formKey;
  final String? error;
  final bool isLoading;

  EnterNewPasswordScreenState({
    required this.passwordTextController,
    required this.passwordConfirmController,
    required this.formKey,
    this.error,
    this.isLoading = false,
  });

  EnterNewPasswordScreenState copyWith({
    TextEditingController? passwordTextController,
    TextEditingController? passwordConfirmController,
    GlobalKey<FormState>? formKey,
    String? error,
    bool? isLoading,
  }) {
    return EnterNewPasswordScreenState(
      passwordTextController:
          passwordTextController ?? this.passwordTextController,
      passwordConfirmController:
          passwordConfirmController ?? this.passwordConfirmController,
      formKey: formKey ?? this.formKey,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
