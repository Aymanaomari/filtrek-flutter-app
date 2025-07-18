class LoginModel {
  final String phoneCountryCode;
  final String phoneNumber;
  final String password;

  LoginModel(
      {required this.phoneCountryCode,
      required this.phoneNumber,
      required this.password});

  // Serialize to JSON
  Map<String, dynamic> toJson() {
    return {
      'phoneCountryCode': phoneCountryCode,
      'phoneNumber': phoneNumber,
      'password': password
    };
  }
}
