import 'package:filtrek_app/features/fltrik/data/models/login_model.dart';
import 'package:filtrek_app/features/fltrik/domain/repositories/authentification_repository.dart';

class LoginUsecase {
  final AuthentificationRepository authentificationRepository;

  LoginUsecase({required this.authentificationRepository});

  Future<bool> call(String email, String password) {
    return authentificationRepository
        .login(LoginModel(email: email, password: password));
  }
}
