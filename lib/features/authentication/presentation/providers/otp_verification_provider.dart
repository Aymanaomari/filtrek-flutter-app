import 'package:filtrek_app/features/authentication/domain/entities/verify_account_entity.dart';
import 'package:filtrek_app/features/authentication/domain/entities/verify_reset_password_entity.dart';
import 'package:filtrek_app/features/authentication/domain/usecases/sent_verification_otp_usecase.dart';
import 'package:filtrek_app/features/authentication/domain/usecases/verify_account_usecase.dart';
import 'package:filtrek_app/features/authentication/domain/usecases/verify_reset_password_usecase.dart';
import 'package:filtrek_app/features/authentication/presentation/providers/auth_provider.dart';
import 'package:filtrek_app/features/authentication/presentation/providers/otp_verification_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:filtrek_app/core/exceptions/http_exception.dart";
import "package:filtrek_app/core/exceptions/network_exception.dart";

// Notifier to manage the OTP state
class OtpVerificationNotifier extends StateNotifier<OtpVerificationState> {
  final VerifyAccountUsecase verifyAccountUsecase;
  final SentVerificationOtpUsecase _sentVerificationOtpUsecase;
  final VerifyResetPasswordUsecase _verifyResetPasswordUsecase;

  OtpVerificationNotifier(this.verifyAccountUsecase,
      this._sentVerificationOtpUsecase, this._verifyResetPasswordUsecase)
      : super(const OtpVerificationState());

  void setOtpCode(String code) {
    state = state.copyWith(otpCode: code);
  }

  resentOtpVerification(
    String userId,
  ) async {
    try {
      await _sentVerificationOtpUsecase.call(userId);
    } on HttpException catch (e) {
      if (e.statusCode == 429) {
        state = state.copyWith(
            resendError: "Too many requests. Please try again later.");
      } else {
        state = state.copyWith(resendError: e.message);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<bool> verifyAccount({
    required String userId,
    required String phone,
    required String pin,
  }) async {
    if (pin.isEmpty) {
      // Optionally, update state with error info
      // state = state.copyWith(error: 'OTP code is required');
      return false;
    }
    try {
      await verifyAccountUsecase
          .call(VerifyAccountEntity(userId: userId, otpCode: pin));
      return true;
    } on HttpException catch (e) {
      // Handle specific HTTP errors if needed
      // Optionally, update state with error info
      state = state.copyWith(error: e.message);
      return false;
    } on NetworkException {
      rethrow;
    } catch (e) {
      // Handle other errors
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  Future<bool> verifyResetPasswordOtp({
    required String userId,
    required String phone,
    required String pin,
  }) async {
    if (pin.isEmpty) {
      state = state.copyWith(error: 'OTP code is required');
      return false;
    }
    try {
      await _verifyResetPasswordUsecase
          .call(VerifyResetPasswordEntity(userId: userId, otpCode: pin));
      return true;
    } on HttpException catch (e) {
      state = state.copyWith(error: e.message);
      return false;
    } on NetworkException {
      rethrow;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }
}

final otpVerificationProvider = StateNotifierProvider.autoDispose<
        OtpVerificationNotifier, OtpVerificationState>(
    (ref) => OtpVerificationNotifier(
        ref.read(verifyAccountUsecaseProvider),
        ref.read(sentVerificationOtpUsecaseProvider),
        ref.read(verifyResetPasswordUsecaseProvider)));
