import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnterEmailScreenState {
  final TextEditingController emailController;
  final GlobalKey<FormState> formKey;
  final String? errorText;

  EnterEmailScreenState({
    required this.emailController,
    required this.formKey,
    this.errorText,
  });

  EnterEmailScreenState copyWith({
    TextEditingController? emailController,
    GlobalKey<FormState>? formKey,
    String? errorText,
  }) {
    return EnterEmailScreenState(
      emailController: emailController ?? this.emailController,
      formKey: formKey ?? this.formKey,
      errorText: errorText,
    );
  }
}

class EnterEmailScreenNotifier extends StateNotifier<EnterEmailScreenState> {
  EnterEmailScreenNotifier()
      : super(EnterEmailScreenState(
          emailController: TextEditingController(),
          formKey: GlobalKey<FormState>(),
        ));

  bool isEmailValid(String email) {
    final regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return regex.hasMatch(email);
  }

  bool validateEmail() {
    final email = state.emailController.text.trim();
    if (email.isEmpty) {
      state = state.copyWith(errorText: "Email is required");
      return false;
    }
    if (!isEmailValid(email)) {
      state = state.copyWith(errorText: "Please enter a valid email address");
      return false;
    }
    state = state.copyWith(errorText: null);
    return true;
  }

  @override
  void dispose() {
    state.emailController.dispose();
    super.dispose();
  }
}

final enterEmailScreenProvider =
    StateNotifierProvider<EnterEmailScreenNotifier, EnterEmailScreenState>(
        (ref) => EnterEmailScreenNotifier());
