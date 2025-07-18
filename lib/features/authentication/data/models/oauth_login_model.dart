import 'package:filtrek_app/features/authentication/domain/entities/oauth_login_entity.dart';

class OAuthLoginModel extends OAuthLoginEntity {
  OAuthLoginModel({
    required String email,
    required String oauthProvider,
    required String oauthId,
    required String name,
    required String profilePictureUrl,
    required String accessToken,
  }) : super(
          email: email,
          oauthProvider: oauthProvider,
          oauthId: oauthId,
          name: name,
          profilePictureUrl: profilePictureUrl,
          accessToken: accessToken,
        );

  factory OAuthLoginModel.fromEntity(OAuthLoginEntity entity) {
    return OAuthLoginModel(
      email: entity.email,
      oauthProvider: entity.oauthProvider,
      oauthId: entity.oauthId,
      name: entity.name,
      profilePictureUrl: entity.profilePictureUrl,
      accessToken: entity.accessToken,
    );
  }

  factory OAuthLoginModel.fromJson(Map<String, dynamic> json) {
    return OAuthLoginModel(
      email: json['email'],
      oauthProvider: json['oauthProvider'],
      oauthId: json['oauthId'],
      name: json['name'],
      profilePictureUrl: json['profile_picture_url'],
      accessToken: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'oauthProvider': oauthProvider,
      'oauthId': oauthId,
      'name': name,
      'profile_picture_url': profilePictureUrl,
      'access_token': accessToken,
    };
  }
}
