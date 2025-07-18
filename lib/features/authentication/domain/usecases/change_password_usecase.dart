import 'package:filtrek_app/features/authentication/domain/repositories/authentification_repository.dart';

class ChangePasswordUsecase {
  final AuthentificationRepository authentificationRepository;

  ChangePasswordUsecase({required this.authentificationRepository});

  call(String newPassword) async {
    await authentificationRepository.changePassword(newPassword);
  }
}
