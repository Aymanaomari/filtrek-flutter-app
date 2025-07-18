import 'package:filtrek_app/features/authentication/domain/entities/request_reset_password_entity.dart';
import 'package:filtrek_app/features/authentication/domain/repositories/authentification_repository.dart';

class RequestResetPasswordUsecase {
  final AuthentificationRepository _authentificationRepository;

  RequestResetPasswordUsecase(
      {required AuthentificationRepository authentificationRepository})
      : _authentificationRepository = authentificationRepository;

  Future<String> call(RequestResetPasswordEntity data) async {
    return await _authentificationRepository.requestResetPassowrd(data);
  }
}
