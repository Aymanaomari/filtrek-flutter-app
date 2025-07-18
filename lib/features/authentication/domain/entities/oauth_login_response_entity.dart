class OauthLoginResponseEntity {
  final String accessToken;
  final String id;
  final String username;
  final String email;
  final bool emailVerified;
  final String? phoneNumber;
  final String? phoneCountryCode;
  final bool phoneVerified;
  final String profilePictureUrl;
  final String status;
  final String role;
  final DateTime? lastLoginAt;

  OauthLoginResponseEntity({
    required this.accessToken,
    required this.id,
    required this.username,
    required this.email,
    required this.emailVerified,
    this.phoneNumber,
    this.phoneCountryCode,
    required this.phoneVerified,
    required this.profilePictureUrl,
    required this.status,
    required this.role,
    this.lastLoginAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
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
}
