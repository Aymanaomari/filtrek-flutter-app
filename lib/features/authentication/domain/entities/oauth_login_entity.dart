import 'package:filtrek_app/features/authentication/data/models/oauth_login_model.dart';

class OAuthLoginEntity {
  final String email;
  final String oauthProvider;
  final String oauthId;
  final String name;
  final String profilePictureUrl;
  final String accessToken;

  OAuthLoginEntity({
    required this.email,
    required this.oauthProvider,
    required this.oauthId,
    required this.name,
    required this.profilePictureUrl,
    required this.accessToken,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'oauthProvider': oauthProvider,
        'oauthId': oauthId,
        'name': name,
        'profile_picture_url': profilePictureUrl,
        'access_token': accessToken,
      };

  // Add a method to convert entity to model
  OAuthLoginModel toModel() {
    return OAuthLoginModel(
      email: email,
      oauthProvider: oauthProvider,
      oauthId: oauthId,
      name: name,
      profilePictureUrl: profilePictureUrl,
      accessToken: accessToken,
    );
  }
}
