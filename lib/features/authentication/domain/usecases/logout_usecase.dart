import 'package:filtrek_app/features/authentication/domain/repositories/authentification_repository.dart';

class LogoutUsecase {
  final AuthentificationRepository _authentificationRepository;

  LogoutUsecase(
      {required AuthentificationRepository authentificationRepository})
      : _authentificationRepository = authentificationRepository;

  call() async {
    return await _authentificationRepository.logout();
  }
}
