import 'package:filtrek_app/core/constant/end_points.dart';
import 'package:filtrek_app/core/class/crud.dart';
import 'package:filtrek_app/features/authentication/data/models/request_reset_password_model.dart';
import 'package:filtrek_app/features/authentication/data/models/verify_reset_password_model.dart';
import 'package:filtrek_app/features/authentication/data/models/signup_model.dart';
import 'package:filtrek_app/features/authentication/data/models/oauth_login_response_model.dart';
import 'package:filtrek_app/features/authentication/data/models/signup_response_model.dart';

class AuthRemoteDatasource {
  final Crud crud;

  AuthRemoteDatasource({required this.crud});

  Future<SignupResponseModel> signup(SignupModel data) async {
    final result = await crud.postData(EndPoints.signup, data.toJson());
    return SignupResponseModel.fromJson(result);
  }

  Future<Map<String, dynamic>> login(Map<String, dynamic> data) async {
    return await crud.postData(EndPoints.login, data);
  }

  Future<OauthLoginResponseModel> oAuthLogin(Map<String, dynamic> data) async {
    final result = await crud.postData(EndPoints.oAuthLogin, data);
    return OauthLoginResponseModel.fromJson(result);
  }

  Future<Map<String, dynamic>> verifyAccount(Map<String, dynamic> data) async {
    return await crud.putData(EndPoints.verifyAccount, data);
  }

  Future<Map<String, dynamic>> requestResetPassword(
      RequestResetPasswordModel data) async {
    return await crud.postData(EndPoints.requestResetPassword, data.toJson());
  }

  Future<Map<String, dynamic>> verifyResetPassword(
      VerifyResetPasswordModel data) async {
    return await crud.postData(EndPoints.verifyResetPasswordOtp, data.toJson());
  }

  Future<void> changePassword(String newPassword, String accessToken) async {
    await crud.postData(EndPoints.changePassword, {"newPassword": newPassword},
        {"authorization": "Bearer $accessToken"});
  }

  Future<void> sendVerificationAccountOtp(String userId) async {
    await crud.postData(EndPoints.sendAccountVerifOtp, {"userId": userId});
  }
}
