import 'package:filtrek_app/features/fltrik/data/models/login_model.dart';
import 'package:filtrek_app/features/fltrik/domain/repositories/authentification_repository.dart';

class AuthentificationRepositoryImp extends AuthentificationRepository {
  @override
  Future<bool> login(LoginModel loginData) async {
    await Future.delayed(Duration(seconds: 3)); // Simulate network delay

    // Simulate a successful login response
    if (loginData.email == "test@example.com" &&
        loginData.password == "password123") {
      return true;
    }

    // Simulate a failed login response
    return false;
  }
}
