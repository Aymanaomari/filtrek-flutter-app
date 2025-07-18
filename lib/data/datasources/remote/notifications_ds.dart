import 'package:filtrek_app/end_points.dart';
import 'package:filtrek_app/core/class/crud.dart';
import 'package:filtrek_app/data/models/notifications/all_notifications_model.dart';

class NotificationRemoteDs {
  final Crud crud;

  NotificationRemoteDs({required this.crud});
  Future<AllNotificationsModel> getUserNotifications(String accessToken) async {
    final result = await crud.getData(
        EndPoints.getAllNotification, {'authorization': 'Bearer $accessToken'});

    final allnotifications = AllNotificationsModel.fromJson(result);
    return allnotifications;
  }

  addFcm(String fcm, String? token) async {
    final result = await crud.postData(EndPoints.getAllNotification,
        {"fcmToken": fcm}, {'authorization': 'Bearer $token'});

    final allnotifications = AllNotificationsModel.fromJson(result);
    return allnotifications;
  }
}
