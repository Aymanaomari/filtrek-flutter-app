import 'dart:io';

import 'package:filtrek_app/domain/entities/user/current_user_response_entity.dart';
import 'package:filtrek_app/domain/repositories/user_repository.dart';

class UploadProfileImageUsecase {
  final UserRepository _userRepository;

  UploadProfileImageUsecase({required UserRepository userRepository})
      : _userRepository = userRepository;

  Future<CurrentUserResponseEntity> call(File image) async {
    return await this._userRepository.uploadProfileImage(image);
  }
}
