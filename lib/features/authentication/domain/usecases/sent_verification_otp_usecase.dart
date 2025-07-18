import 'package:filtrek_app/features/authentication/domain/repositories/authentification_repository.dart';

class SentVerificationOtpUsecase {
  final AuthentificationRepository authRepository;

  SentVerificationOtpUsecase({required this.authRepository});

  call(String userId) async {
    await authRepository.sentVerificationAccountOtp(userId);
  }
}
