import 'package:filtrek_app/features/authentication/data/models/login_model.dart';
import 'package:filtrek_app/features/authentication/domain/repositories/authentification_repository.dart';

class LoginUsecase {
  final AuthentificationRepository authentificationRepository;

  LoginUsecase({required this.authentificationRepository});

  Future<dynamic> call(
      String phoneCountryCode, String phoneNumber, String password) async {
    return await authentificationRepository.login(LoginModel(
        phoneCountryCode: phoneCountryCode,
        phoneNumber: phoneNumber,
        password: password));
  }
}
