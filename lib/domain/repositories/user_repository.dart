import 'dart:io';

import 'package:filtrek_app/domain/entities/user/current_user_response_entity.dart';
import 'package:filtrek_app/domain/entities/user/current_user_update_entity.dart';

abstract class UserRepository {
  Future<CurrentUserResponseEntity?> getCurrentUser();
  Future<CurrentUserResponseEntity> updateUser(CurrentUserUpdateEntity data);
  Future<CurrentUserResponseEntity> uploadProfileImage(File image);
}
