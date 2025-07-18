import 'package:filtrek_app/features/authentication/domain/entities/oauth_login_entity.dart';
import 'package:filtrek_app/features/authentication/domain/entities/oauth_login_response_entity.dart';
import 'package:filtrek_app/features/authentication/domain/repositories/authentification_repository.dart';

class OauthLoginUsecase {
  final AuthentificationRepository authRepository;

  OauthLoginUsecase({required this.authRepository});

  Future<OauthLoginResponseEntity> call(
      OAuthLoginEntity oAuthLoginEntity) async {
    var response = await authRepository.oAuthLogin(oAuthLoginEntity.toModel());
    return response;
  }
}
