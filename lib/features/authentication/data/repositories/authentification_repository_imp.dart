import 'package:filtrek_app/features/authentication/data/datasources/local/auth_local_datasource.dart';
import 'package:filtrek_app/features/authentication/data/datasources/remote/auth_remote_ds.dart';
import 'package:filtrek_app/features/authentication/data/models/login_model.dart';
import 'package:filtrek_app/features/authentication/data/models/oauth_login_model.dart';
import 'package:filtrek_app/features/authentication/data/models/request_reset_password_model.dart';
import 'package:filtrek_app/features/authentication/data/models/verify_account_model.dart';
import 'package:filtrek_app/features/authentication/data/models/verify_reset_password_model.dart';
import 'package:filtrek_app/features/authentication/domain/entities/oauth_login_response_entity.dart';
import 'package:filtrek_app/features/authentication/domain/entities/request_reset_password_entity.dart';
import 'package:filtrek_app/features/authentication/domain/entities/signup_entity.dart';
import 'package:filtrek_app/features/authentication/domain/entities/signup_response_entity.dart';
import 'package:filtrek_app/features/authentication/domain/entities/verify_reset_password_entity.dart';
import 'package:filtrek_app/features/authentication/domain/repositories/authentification_repository.dart';

class AuthentificationRepositoryImp extends AuthentificationRepository {
  final AuthRemoteDatasource authRemoteDs;
  final AuthLocalDataSource authLocalDs;

  AuthentificationRepositoryImp({
    required this.authRemoteDs,
    required this.authLocalDs,
  });

  @override
  login(LoginModel loginData) async {
    var response = await authRemoteDs.login(loginData.toJson());
    if (response['accessToken'] != null) {
      await authLocalDs.saveAccessToken(response['accessToken']);
    }
    return response;
  }

  @override
  Future<SignupResponseEntity> signup(SignupEntity signupData) async {
    final response = await authRemoteDs.signup(signupData.toModel());
    await authRemoteDs.sendVerificationAccountOtp(response.id);
    return response.toEntity();
  }

  @override
  Future<OauthLoginResponseEntity> oAuthLogin(
      OAuthLoginModel oAuthLoginData) async {
    final oAuthResponse =
        await authRemoteDs.oAuthLogin(oAuthLoginData.toJson());
    await authLocalDs.saveAccessToken(oAuthResponse.accessToken);
    return oAuthResponse.toEntity();
  }

  @override
  Future verifyAccount(VerifyAccountModel verifyAccountmodel) async {
    var response =
        await authRemoteDs.verifyAccount(verifyAccountmodel.toJson());
    if (response['accessToken'] != null) {
      await authLocalDs.saveAccessToken(response['accessToken']);
    }
  }

  @override
  Future<String> requestResetPassowrd(RequestResetPasswordEntity data) async {
    var response = await authRemoteDs
        .requestResetPassword(RequestResetPasswordModel.fromEntity(data));
    String userId = response["userId"];
    return userId;
  }

  @override
  verifyResetPassword(VerifyResetPasswordEntity data) async {
    var response = await authRemoteDs
        .verifyResetPassword(VerifyResetPasswordModel.fromEntity(data));
    if (response['accessToken'] != null) {
      await authLocalDs.saveAccessToken(response['accessToken']);
    }
  }

  @override
  changePassword(String newPassword) async {
    String? accessToken = await authLocalDs.getAccessToken();
    if (accessToken == null || accessToken.isEmpty) {
      return null;
    }
    await authRemoteDs.changePassword(newPassword, accessToken);
  }

  @override
  logout() async {
    await authLocalDs.clearAccessToken();
  }

  @override
  sentVerificationAccountOtp(String userId) async {
    await authRemoteDs.sendVerificationAccountOtp(userId);
  }
}
