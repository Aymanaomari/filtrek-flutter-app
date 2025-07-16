import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnterNewPasswordScreenState {
  final TextEditingController pass1;
  final TextEditingController pass2;
  final GlobalKey<FormState> formKey;
  final bool isLoading;

  EnterNewPasswordScreenState({
    required this.pass1,
    required this.pass2,
    required this.formKey,
    this.isLoading = false,
  });

  EnterNewPasswordScreenState copyWith({
    TextEditingController? pass1,
    TextEditingController? pass2,
    GlobalKey<FormState>? formKey,
    bool? isLoading,
  }) {
    return EnterNewPasswordScreenState(
      pass1: pass1 ?? this.pass1,
      pass2: pass2 ?? this.pass2,
      formKey: formKey ?? this.formKey,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class EnterNewPasswordScreenNotifier
    extends StateNotifier<EnterNewPasswordScreenState> {
  EnterNewPasswordScreenNotifier()
      : super(EnterNewPasswordScreenState(
          pass1: TextEditingController(),
          pass2: TextEditingController(),
          formKey: GlobalKey<FormState>(),
        ));

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  bool validateForm() {
    return state.formKey.currentState?.validate() ?? false;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != state.pass1.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> resetPassword() async {
    if (!validateForm()) return;

    setLoading(true);
    try {
      await Future.delayed(Duration(seconds: 2)); // Simulate API call

      // Handle success
      print('Password reset successful');
    } catch (e) {
      // Handle error
      print('Password reset failed: $e');
    } finally {
      setLoading(false);
    }
  }

  @override
  void dispose() {
    state.pass1.dispose();
    state.pass2.dispose();
    super.dispose();
  }
}

final enterNewPasswordScreenProvider = StateNotifierProvider<
    EnterNewPasswordScreenNotifier, EnterNewPasswordScreenState>(
  (ref) => EnterNewPasswordScreenNotifier(),
);
