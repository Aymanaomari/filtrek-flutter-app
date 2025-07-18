import 'package:filtrek_app/features/authentication/domain/entities/signup_entity.dart';
import 'package:filtrek_app/features/authentication/domain/entities/signup_response_entity.dart';
import 'package:filtrek_app/features/authentication/domain/repositories/authentification_repository.dart';

class SignupUsecase {
  final AuthentificationRepository authRepository;

  SignupUsecase({required this.authRepository});

  Future<SignupResponseEntity> call(SignupEntity signupEntity) async {
    return await authRepository.signup(signupEntity);
  }
}
