import 'package:filtrek_app/features/authentication/data/models/login_model.dart';
import 'package:filtrek_app/features/authentication/data/models/oauth_login_model.dart';
import 'package:filtrek_app/features/authentication/data/models/verify_account_model.dart';
import 'package:filtrek_app/features/authentication/domain/entities/oauth_login_response_entity.dart';
import 'package:filtrek_app/features/authentication/domain/entities/request_reset_password_entity.dart';
import 'package:filtrek_app/features/authentication/domain/entities/signup_entity.dart';
import 'package:filtrek_app/features/authentication/domain/entities/signup_response_entity.dart';
import 'package:filtrek_app/features/authentication/domain/entities/verify_reset_password_entity.dart';

abstract class AuthentificationRepository {
  Future<dynamic> login(LoginModel loginData);
  Future<SignupResponseEntity> signup(SignupEntity signupData);
  Future<OauthLoginResponseEntity> oAuthLogin(OAuthLoginModel oAuthLoginData);
  Future<dynamic> verifyAccount(VerifyAccountModel verifyAccountmodel);
  sentVerificationAccountOtp(String userId);
  Future<String> requestResetPassowrd(RequestResetPasswordEntity data);
  verifyResetPassword(VerifyResetPasswordEntity data);
  changePassword(String newPassword);
  logout();
}
