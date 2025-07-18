import 'package:filtrek_app/features/authentication/domain/entities/verify_reset_password_entity.dart';
import 'package:filtrek_app/features/authentication/domain/repositories/authentification_repository.dart';

class VerifyResetPasswordUsecase {
  final AuthentificationRepository authentificationRepository;
  VerifyResetPasswordUsecase({required this.authentificationRepository});

  call(VerifyResetPasswordEntity data) async {
    await authentificationRepository.verifyResetPassword(data);
  }
}
