import 'package:flutter/material.dart';

class ChangePasswordScreenState {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final String? error;
  final bool isLoading;
  final bool isSuccess;

  ChangePasswordScreenState({
    required this.passwordController,
    required this.confirmPasswordController,
    this.error,
    this.isLoading = false,
    this.isSuccess = false,
  });

  ChangePasswordScreenState copyWith({
    TextEditingController? passwordController,
    TextEditingController? confirmPasswordController,
    String? error,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return ChangePasswordScreenState(
      passwordController: passwordController ?? this.passwordController,
      confirmPasswordController:
          confirmPasswordController ?? this.confirmPasswordController,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
