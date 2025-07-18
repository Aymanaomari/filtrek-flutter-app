import 'package:filtrek_app/features/authentication/domain/entities/signup_entity.dart';

class SignupModel {
  final String username;
  final String password;
  final String phoneCountryCode;
  final String phoneNumber;

  SignupModel({
    required this.username,
    required this.password,
    required this.phoneCountryCode,
    required this.phoneNumber,
  });

  // Convert SignupModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'phoneCountryCode': phoneCountryCode,
      'phoneNumber': phoneNumber,
    };
  }

  // Create SignupModel from JSON
  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      phoneCountryCode: json['phoneCountryCode'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
    );
  }

  // Convert to JSON string
  String toJsonString() {
    return toJson().toString();
  }

  // Copy with method for creating modified copies
  SignupModel copyWith({
    String? username,
    String? email,
    String? password,
    String? phoneCountryCode,
    String? phoneNumber,
    String? verificationMethod,
  }) {
    return SignupModel(
      username: username ?? this.username,
      password: password ?? this.password,
      phoneCountryCode: phoneCountryCode ?? this.phoneCountryCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  // Convert SignupModel to SignupEntity (Model -> Entity)
  SignupEntity toEntity() {
    return SignupEntity(
      username: username,
      password: password,
      phoneCountryCode: phoneCountryCode,
      phoneNumber: phoneNumber,
    );
  }

  // Create SignupModel from SignupEntity (Entity -> Model)
  factory SignupModel.fromEntity(SignupEntity entity) {
    return SignupModel(
      username: entity.username,
      password: entity.password,
      phoneCountryCode: entity.phoneCountryCode,
      phoneNumber: entity.phoneNumber,
    );
  }

  @override
  String toString() {
    return 'SignupModel(username: $username, password: $password, phoneCountryCode: $phoneCountryCode, phoneNumber: $phoneNumber)';
  }
}
