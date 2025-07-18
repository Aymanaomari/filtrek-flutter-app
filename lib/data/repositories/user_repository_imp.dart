import 'dart:io';

import 'package:filtrek_app/features/authentication/data/datasources/local/auth_local_datasource.dart';
import 'package:filtrek_app/data/datasources/local/user/user_local_ds.dart';
import 'package:filtrek_app/data/datasources/remote/user_remote_ds.dart';
import 'package:filtrek_app/domain/entities/user/current_user_response_entity.dart';
import 'package:filtrek_app/domain/entities/user/current_user_update_entity.dart';
import 'package:filtrek_app/domain/repositories/user_repository.dart';

class UserRepositoryImp extends UserRepository {
  final UserRemoteDs remoteDs;
  final UserLocalDs localDs;
  final AuthLocalDataSource authLocalDs;

  UserRepositoryImp({
    required this.remoteDs,
    required this.localDs,
    required this.authLocalDs,
  });

  @override
  Future<CurrentUserResponseEntity?> getCurrentUser() async {
    String? accessToken = await authLocalDs.getAccessToken();
    if (accessToken == null || accessToken.isEmpty) {
      return null;
    }
    final result = await remoteDs.getCurrentUser(accessToken);
    await localDs.saveCurrentUser(result);
    return result.toEntity();
  }

  @override
  Future<CurrentUserResponseEntity> updateUser(
      CurrentUserUpdateEntity data) async {
    String? accessToken = await authLocalDs.getAccessToken();
    final updatedUserModel =
        await remoteDs.updateUser(accessToken!, data.toModel());
    await localDs.saveCurrentUser(updatedUserModel);
    return updatedUserModel.toEntity();
  }

  @override
  Future<CurrentUserResponseEntity> uploadProfileImage(File image) async {
    String? accessToken = await authLocalDs.getAccessToken();
    if (accessToken == null || accessToken.isEmpty) {
      throw Exception('Access token is missing');
    }
    final updatedUserModel =
        await remoteDs.udpateUserProfile(accessToken, image);
    await localDs.saveCurrentUser(updatedUserModel);
    return updatedUserModel.toEntity();
  }
}
