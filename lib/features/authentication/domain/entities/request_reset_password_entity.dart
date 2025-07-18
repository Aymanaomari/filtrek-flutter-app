class RequestResetPasswordEntity {
  final String phoneCountryCode;
  final String phoneNumber;

  RequestResetPasswordEntity({
    required this.phoneCountryCode,
    required this.phoneNumber,
  });
}
