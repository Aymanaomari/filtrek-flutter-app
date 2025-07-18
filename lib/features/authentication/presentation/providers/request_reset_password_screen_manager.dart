import 'package:filtrek_app/core/exceptions/http_exception.dart';
import 'package:filtrek_app/core/exceptions/network_exception.dart';
import 'package:filtrek_app/features/authentication/domain/entities/request_reset_password_entity.dart';
import 'package:filtrek_app/features/authentication/domain/usecases/request_reset_password_usecase.dart';
import 'package:filtrek_app/features/authentication/presentation/providers/auth_provider.dart';
import 'package:filtrek_app/features/authentication/presentation/providers/request_reset_password_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:phone_text_field/model/phone_number.dart';

class RequestResetPasswordScreenManager
    extends StateNotifier<RequestResetPasswordScreenState> {
  final RequestResetPasswordUsecase _requestResetPasswordUsecase;

  RequestResetPasswordScreenManager(this._requestResetPasswordUsecase)
      : super(RequestResetPasswordScreenState(
          phoneController: ValueNotifier<PhoneNumber?>(null),
        ));

  /// Request password reset
  Future<bool> requestPasswordReset() async {
    try {
      // Set loading state and clear previous errors
      state = state.copyWith(isLoading: true, errorMessage: null);

      // Validate phone number
      final phoneNumber = state.phoneController.value;
      if (phoneNumber == null || phoneNumber.number.isEmpty) {
        state = state.copyWith(
          isLoading: false,
          errorMessage:
              "Invalid phone number. Please provide a valid phone number.",
        );
        return false;
      }

      // Create entity for the usecase
      final entity = RequestResetPasswordEntity(
        phoneCountryCode: phoneNumber.countryCode,
        phoneNumber: phoneNumber.number,
      );

      // Call the usecase to request password reset
      final result = await _requestResetPasswordUsecase.call(entity);

      // Update state with success
      state = state.copyWith(
        isLoading: false,
        userId: result,
      );

      return true;
    } on HttpException catch (e) {
      if (e.statusCode == 404) {
        state = state.copyWith(
          isLoading: false,
          errorMessage:
              "No account found with this phone number. Please check the number or create a new account.",
        );
      }

      return false;
    } on NetworkException {
      rethrow;
    }
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  /// Update phone number
  void updatePhoneNumber(PhoneNumber number) {
    state = state.copyWith(
      phoneController: ValueNotifier(
        PhoneNumber(
          number: number.number,
          countryCode: number.countryCode,
          countryISOCode: number.countryISOCode,
        ),
      ),
    );
  }
}

/// Provider for the RequestResetPasswordScreenManager
final requestResetPasswordScreenManagerProvider =
    StateNotifierProvider.autoDispose<RequestResetPasswordScreenManager,
        RequestResetPasswordScreenState>(
  (ref) => RequestResetPasswordScreenManager(
      ref.read(requestResetPasswordUsecaseProvider)),
);
