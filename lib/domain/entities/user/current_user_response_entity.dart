import 'package:filtrek_app/data/models/user/current_user_response_model.dart';

class CurrentUserResponseEntity {
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

  CurrentUserResponseEntity({
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
    };
  }

  CurrentUserResponseModel toModel() {
    return CurrentUserResponseModel(
      id: id,
      username: username,
      email: email,
      emailVerified: emailVerified,
      phoneNumber: phoneNumber,
      phoneCountryCode: phoneCountryCode,
      phoneVerified: phoneVerified,
      profilePictureUrl: profilePictureUrl,
      status: status,
      role: role,
      lastLoginAt: lastLoginAt,
      gender: gender,
      weight: weight,
      age: age,
    );
  }

  CurrentUserResponseEntity copyWith({
    String? id,
    String? username,
    String? email,
    bool? emailVerified,
    String? phoneNumber,
    String? phoneCountryCode,
    bool? phoneVerified,
    String? profilePictureUrl,
    String? status,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLoginAt,
    String? gender,
    double? weight,
    int? age,
  }) {
    return CurrentUserResponseEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneCountryCode: phoneCountryCode ?? this.phoneCountryCode,
      phoneVerified: phoneVerified ?? this.phoneVerified,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      status: status ?? this.status,
      role: role ?? this.role,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      age: age ?? this.age,
    );
  }
}
