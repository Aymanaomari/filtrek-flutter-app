import 'package:filtrek_app/core/class/crud.dart';
import 'package:filtrek_app/features/authentication/data/datasources/local/auth_local_datasource.dart';
import 'package:filtrek_app/features/authentication/data/datasources/remote/auth_remote_ds.dart';
import 'package:filtrek_app/features/authentication/data/repositories/authentification_repository_imp.dart';
import 'package:filtrek_app/features/authentication/domain/repositories/authentification_repository.dart';
import 'package:filtrek_app/features/authentication/domain/usecases/change_password_usecase.dart';
import 'package:filtrek_app/features/authentication/domain/usecases/login_usecase.dart';
import 'package:filtrek_app/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:filtrek_app/features/authentication/domain/usecases/oauth_login_usecase.dart';
import 'package:filtrek_app/features/authentication/domain/usecases/request_reset_password_usecase.dart';
import 'package:filtrek_app/features/authentication/domain/usecases/sent_verification_otp_usecase.dart';
import 'package:filtrek_app/features/authentication/domain/usecases/signup_usecase.dart';
import 'package:filtrek_app/features/authentication/domain/usecases/verify_account_usecase.dart';
import 'package:filtrek_app/features/authentication/domain/usecases/verify_reset_password_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRemoteDataSourceProvider =
    Provider<AuthRemoteDatasource>((ref) => AuthRemoteDatasource(crud: Crud()));

final authLocalDataSourceProvider =
    Provider<AuthLocalDataSource>((ref) => AuthLocalDataSource());

final authentificationRepositoryProvider = Provider<AuthentificationRepository>(
    (ref) => AuthentificationRepositoryImp(
        authRemoteDs: ref.read(authRemoteDataSourceProvider),
        authLocalDs: ref.read(authLocalDataSourceProvider)));

final loginUsecaseProvider = Provider<LoginUsecase>((ref) {
  return LoginUsecase(
      authentificationRepository: ref.read(authentificationRepositoryProvider));
});

final signupUsecaseProvider = Provider<SignupUsecase>((ref) {
  return SignupUsecase(
      authRepository: ref.read(authentificationRepositoryProvider));
});

final oAuthUseCaseProvider = Provider<OauthLoginUsecase>((ref) {
  return OauthLoginUsecase(
      authRepository: ref.read(authentificationRepositoryProvider));
});

final sentVerificationOtpUsecaseProvider = Provider<SentVerificationOtpUsecase>(
    (ref) => SentVerificationOtpUsecase(
        authRepository: ref.read(authentificationRepositoryProvider)));

final verifyAccountUsecaseProvider = Provider<VerifyAccountUsecase>((ref) =>
    VerifyAccountUsecase(
        authentificationRepository:
            ref.read(authentificationRepositoryProvider)));

final requestResetPasswordUsecaseProvider =
    Provider<RequestResetPasswordUsecase>((ref) => RequestResetPasswordUsecase(
        authentificationRepository:
            ref.read(authentificationRepositoryProvider)));

final verifyResetPasswordUsecaseProvider = Provider<VerifyResetPasswordUsecase>(
    (ref) => VerifyResetPasswordUsecase(
        authentificationRepository:
            ref.read(authentificationRepositoryProvider)));

final changePasswordUsecaseProvider = Provider<ChangePasswordUsecase>((ref) {
  return ChangePasswordUsecase(
      authentificationRepository: ref.read(authentificationRepositoryProvider));
});

final logoutUsecaseProvider = Provider<LogoutUsecase>((ref) {
  return LogoutUsecase(
      authentificationRepository: ref.read(authentificationRepositoryProvider));
});
