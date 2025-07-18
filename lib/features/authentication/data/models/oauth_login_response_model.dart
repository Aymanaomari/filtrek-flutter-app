import 'package:filtrek_app/features/authentication/domain/entities/oauth_login_response_entity.dart';

class OauthLoginResponseModel extends OauthLoginResponseEntity {
  OauthLoginResponseModel({
    required String accessToken,
    required String id,
    required String username,
    required String email,
    required bool emailVerified,
    String? phoneNumber,
    String? phoneCountryCode,
    required bool phoneVerified,
    required String profilePictureUrl,
    required String status,
    required String role,
    DateTime? lastLoginAt,
  }) : super(
          accessToken: accessToken,
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
        );

  factory OauthLoginResponseModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] ?? {};
    return OauthLoginResponseModel(
      accessToken: json['accessToken'] as String,
      id: user['id'] as String,
      username: user['username'] as String,
      email: user['email'] as String,
      emailVerified: user['email_verified'] as bool,
      phoneNumber: user['phone_number'] as String?,
      phoneCountryCode: user['phone_country_code'] as String?,
      phoneVerified: user['phone_verified'] as bool,
      profilePictureUrl: user['profile_picture_url'] as String,
      status: user['status'] as String,
      role: user['role'] as String,
      lastLoginAt: user['last_login_at'] != null
          ? DateTime.tryParse(user['last_login_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'user': {
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
      },
    };
  }

  OauthLoginResponseEntity toEntity() {
    return OauthLoginResponseEntity(
      accessToken: accessToken,
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
    );
  }
}
