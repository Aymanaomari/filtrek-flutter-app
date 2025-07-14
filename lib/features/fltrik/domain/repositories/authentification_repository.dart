import 'package:filtrek_app/features/fltrik/data/models/login_model.dart';

abstract class AuthentificationRepository {
  Future<bool> login(LoginModel loginData);
}
