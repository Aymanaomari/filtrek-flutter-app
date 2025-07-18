import 'package:flutter/material.dart';
import 'package:phone_text_field/model/phone_number.dart';

class RequestResetPasswordScreenState {
  final bool isLoading;
  final String? errorMessage;
  final String? userId;
  final ValueNotifier<PhoneNumber?> phoneController;

  RequestResetPasswordScreenState({
    this.isLoading = false,
    this.errorMessage,
    this.userId,
    ValueNotifier<PhoneNumber?>? phoneController,
  }) : phoneController = phoneController ?? ValueNotifier<PhoneNumber?>(null);

  RequestResetPasswordScreenState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? userId,
    ValueNotifier<PhoneNumber?>? phoneController,
  }) {
    return RequestResetPasswordScreenState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      userId: userId ?? this.userId,
      phoneController: phoneController ?? this.phoneController,
    );
  }
}
