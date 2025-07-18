import 'package:filtrek_app/domain/entities/user/current_user_response_entity.dart';

class CurrentUserResponseModel {
  final String id;
  final String username;
  final String email;
  final bool emailVerified;
  final String? phoneNumber;
  final String? phoneCountryCode;
  final bool phoneVerified;
  final String? profilePictureUrl;
  final String status;
  final String role;
  final DateTime? lastLoginAt;
  final String? gender;
  final double? weight;
  final int? age;

  CurrentUserResponseModel({
    required this.id,
    required this.username,
    required this.email,
    required this.emailVerified,
    this.phoneNumber,
    this.phoneCountryCode,
    required this.phoneVerified,
    this.profilePictureUrl,
    required this.status,
    required this.role,
    this.lastLoginAt,
    this.gender,
    this.weight,
    this.age,
  });

  factory CurrentUserResponseModel.fromJson(Map<String, dynamic> json) {
    return CurrentUserResponseModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String? ?? "",
      emailVerified: json['email_verified'] as bool? ?? false,
      phoneNumber: json['phone_number'] as String?,
      phoneCountryCode: json['phone_country_code'] as String?,
      phoneVerified: json['phone_verified'] as bool? ?? false,
      profilePictureUrl: json['profile_picture_url'] as String?,
      status: json['status'] as String? ?? "ACTIVE",
      role: json['role'] as String? ?? "user",
      lastLoginAt: json['last_login_at'] != null
          ? DateTime.parse(json['last_login_at'] as String)
          : null,
      gender: json['gender'] as String?,
      weight:
          (json['weight'] is num) ? (json['weight'] as num).toDouble() : null,
      age: json['age'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'email_verified': emailVerified,
      'phone_number': phoneNumber,
      'phone_country_code': phoneCountryCode,
      'phone_verified': phoneVerified,
      'profile_picture_url': profilePictureUrl,
      'status': status,
      'role': role,
      'last_login_at': lastLoginAt?.toIso8601String(),
      'gender': gender,
      'weight': weight,
      'age': age,
    };
  }

  CurrentUserResponseEntity toEntity() {
    return CurrentUserResponseEntity(
      id: id,
      username: username,
      email: email,
      emailVerified: emailVerified,
      phoneNumber: phoneNumber,
      phoneCountryCode: phoneCountryCode,
      phoneVerified: phoneVerified,
      profilePictureUrl: profilePictureUrl,
      status: status,
      lastLoginAt: lastLoginAt,
      gender: gender,
      weight: weight,
      age: age,
      role: role,
    );
  }
}
