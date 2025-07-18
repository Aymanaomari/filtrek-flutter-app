import 'package:filtrek_app/domain/entities/user/current_user_response_entity.dart';
import 'package:filtrek_app/domain/entities/user/current_user_update_entity.dart';
import 'package:filtrek_app/domain/repositories/user_repository.dart';

class UpdateCurrentUserUsecase {
  final UserRepository _userRepository;

  UpdateCurrentUserUsecase({required UserRepository userRepository})
      : _userRepository = userRepository;

  Future<CurrentUserResponseEntity> call(CurrentUserUpdateEntity data) async {
    return await _userRepository.updateUser(data);
  }
}
