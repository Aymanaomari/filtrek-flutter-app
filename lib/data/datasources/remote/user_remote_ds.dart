import 'dart:io';

import 'package:filtrek_app/end_points.dart';
import 'package:filtrek_app/core/class/crud.dart';
import 'package:filtrek_app/data/models/user/current_user_response_model.dart';
import 'package:filtrek_app/data/models/user/current_user_update_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class UserRemoteDs {
  final Crud crud;

  UserRemoteDs({required this.crud});

  Future<CurrentUserResponseModel> getCurrentUser(String accessToken) async {
    var result = await crud.getData(
        EndPoints.currentUser, {'authorization': 'Bearer $accessToken'});
    return CurrentUserResponseModel.fromJson(result);
  }

  Future<CurrentUserResponseModel> updateUser(
      String accessToken, CurrentUserUpdateModel data) async {
    final result = await crud.patchData(EndPoints.updateUserInfo, data.toJson(),
        {'authorization': 'Bearer $accessToken'});
    return CurrentUserResponseModel.fromJson(result);
  }

  Future<CurrentUserResponseModel> udpateUserProfile(
      String accessToken, File image) async {
    final url = EndPoints.uploaadUserProfile;
    final file = await http.MultipartFile.fromPath(
      'image',
      image.path,
      contentType: MediaType('image', 'jpeg'), // Change to match your file type
    );
    final result = await crud.uploadFormData(
      url,
      {}, // fields if needed
      [file],
      {'authorization': 'Bearer $accessToken'},
    );
    return CurrentUserResponseModel.fromJson(result);
  }
}
