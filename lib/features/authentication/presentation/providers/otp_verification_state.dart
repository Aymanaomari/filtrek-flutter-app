// State class to hold the OTP code
class OtpVerificationState {
  final String otpCode;
  final String? error;
  final bool isLoading;
  final String? resendError;
  const OtpVerificationState({
    this.otpCode = '',
    this.error,
    this.isLoading = false,
    this.resendError,
  });

  OtpVerificationState copyWith({
    String? otpCode,
    String? error,
    bool? isLoading,
    String? resendError,
  }) {
    return OtpVerificationState(
      otpCode: otpCode ?? this.otpCode,
      error: error,
      isLoading: isLoading ?? this.isLoading,
      resendError: resendError,
    );
  }
}
