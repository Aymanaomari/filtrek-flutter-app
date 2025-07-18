import 'package:filtrek_app/features/authentication/data/models/signup_model.dart';

class SignupEntity {
  final String username;
  final String password;
  final String phoneCountryCode;
  final String phoneNumber;

  const SignupEntity({
    required this.username,
    required this.password,
    required this.phoneCountryCode,
    required this.phoneNumber,
  });

  // Convert SignupEntity to SignupModel (Entity -> Model)
  SignupModel toModel() {
    return SignupModel(
      username: username,
      password: password,
      phoneCountryCode: phoneCountryCode,
      phoneNumber: phoneNumber,
    );
  }

  // Create SignupEntity from SignupModel (Model -> Entity)
  factory SignupEntity.fromModel(SignupModel model) {
    return SignupEntity(
      username: model.username,
      password: model.password,
      phoneCountryCode: model.phoneCountryCode,
      phoneNumber: model.phoneNumber,
    );
  }

  // Copy with method for creating modified copies
  SignupEntity copyWith({
    String? username,
    String? email,
    String? password,
    String? phoneCountryCode,
    String? phoneNumber,
    String? verificationMethod,
  }) {
    return SignupEntity(
      username: username ?? this.username,
      password: password ?? this.password,
      phoneCountryCode: phoneCountryCode ?? this.phoneCountryCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  // Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SignupEntity &&
        other.username == username &&
        other.password == password &&
        other.phoneCountryCode == phoneCountryCode &&
        other.phoneNumber == phoneNumber;
  }

  // Hash code
  @override
  int get hashCode {
    return Object.hash(
      username,
      password,
      phoneCountryCode,
      phoneNumber,
    );
  }

  // String representation
  @override
  String toString() {
    return 'SignupEntity(username: $username, password: $password, phoneCountryCode: $phoneCountryCode, phoneNumber: $phoneNumber)';
  }

  // Validation methods
  bool get isValid {
    return username.isNotEmpty &&
        password.isNotEmpty &&
        phoneCountryCode.isNotEmpty &&
        phoneNumber.isNotEmpty &&
        isValidPassword;
  }

  bool get isValidPassword {
    return password.length >= 6;
  }

  String? get passwordError {
    if (password.isEmpty) return 'Password is required';
    if (!isValidPassword) return 'Password must be at least 6 characters';
    return null;
  }

  String? get usernameError {
    if (username.isEmpty) return 'Username is required';
    if (username.length < 3) return 'Username must be at least 3 characters';
    return null;
  }

  String? get phoneError {
    if (phoneNumber.isEmpty) return 'Phone number is required';
    if (phoneCountryCode.isEmpty) return 'Please select a country';
    return null;
  }
}
