import 'package:filtrek_app/features/authentication/domain/entities/signup_response_entity.dart';
import 'package:flutter/material.dart';
import 'package:phone_text_field/model/phone_number.dart';

class SignupScreenState {
  final TextEditingController passwordController;
  final TextEditingController usernameController;
  final TextEditingController mobileController;
  final ValueNotifier<PhoneNumber?> phoneController;
  final String? phoneNumberError;
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  final String? errorMessage;
  final SignupResponseEntity? signupResponseEntity;

  SignupScreenState({
    required this.signupResponseEntity,
    required this.passwordController,
    required this.usernameController,
    required this.mobileController,
    required this.phoneController,
    required this.formKey,
    this.isLoading = false, // Default to false for safety
    this.errorMessage,
    this.phoneNumberError = null,
  });

  SignupScreenState copyWith(
      {TextEditingController? passwordController,
      TextEditingController? usernameController,
      TextEditingController? mobileController,
      ValueNotifier<PhoneNumber?>? phoneController,
      GlobalKey<FormState>? formKey,
      bool? isLoading,
      String? errorMessage,
      SignupResponseEntity? signupResponseEntity,
      String? phoneNumberError}) {
    return SignupScreenState(
      signupResponseEntity: signupResponseEntity ?? this.signupResponseEntity,
      passwordController: passwordController ?? this.passwordController,
      usernameController: usernameController ?? this.usernameController,
      mobileController: mobileController ?? this.mobileController,
      phoneController: phoneController ?? this.phoneController,
      formKey: formKey ?? this.formKey,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      phoneNumberError: phoneNumberError ?? this.phoneNumberError,
    );
  }
}
