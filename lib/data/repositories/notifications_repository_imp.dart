import 'dart:async';
import 'package:filtrek_app/end_points.dart';
import 'package:filtrek_app/features/authentication/data/datasources/local/auth_local_datasource.dart';
import 'package:filtrek_app/data/datasources/remote/notifications_ds.dart';
import 'package:filtrek_app/data/datasources/local/notifications/notification_local_ds.dart';
import 'package:filtrek_app/data/models/notifications/all_notifications_model.dart';
import 'package:filtrek_app/domain/entities/notification/get_all_notification_entity.dart';
import 'package:filtrek_app/domain/repositories/notification_repository.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class NotificationRepositoryImpl implements NotificationRepository {
  IO.Socket? socket;
  final AuthLocalDataSource authLocalDs;
  final NotificationRemoteDs notificationRemoteDs;
  final NotificationLocalDs notificationLocalDs;

  NotificationRepositoryImpl(
      this.authLocalDs, this.notificationRemoteDs, this.notificationLocalDs);

  @override
  Future<AllNotificationsEntity> fetchAll() async {
    final String? token = await authLocalDs.getAccessToken();
    if (token == null || token.isEmpty) {
      return AllNotificationsEntity(notifications: []);
    }
    final data = await notificationRemoteDs.getUserNotifications(token);
    return data.toEntity();
  }

  @override
  Stream<NotificationEntity> listenNew() async* {
    final String? token = await authLocalDs.getAccessToken();
    if (token == null || token.isEmpty) {
      yield* Stream.empty();
      return;
    }
    final String url = '${EndPoints.wsPrefix}/notifications?token=$token';
    socket = IO.io(url, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    socket!.onConnect((_) => print("connected"));
    socket!.onConnectError((err) => print("connect error: $err"));
    socket!.onError((err) => print("error: $err"));
    socket!.onDisconnect((_) => print("disconnected"));
    final controller = StreamController<NotificationEntity>();
    socket!.on('newNotification', (data) {
      controller.add(NotificationEntity(
          id: data['_id'] ?? '',
          message: data['message'] ?? '',
          notificationType: notificationTypeFromString(data["type"] ?? "NEWS"),
          createdAt: data["createdAt"]));
    });
    yield* controller.stream;
  }

  @override
  Future<void> enableNotifications() async {
    await notificationLocalDs.enableNotifications();
  }

  @override
  Future<void> disableNotifications() async {
    await notificationLocalDs.disableNotifications();
  }

  @override
  Future<NotificationStatus> getNotificationStatus() async {
    return await notificationLocalDs.getNotificationStatus();
  }

  @override
  addFcmToken(String fcm) async {
    final String? token = await authLocalDs.getAccessToken();
    if (token == null || token.isEmpty) {
      return null;
    }
    return await notificationRemoteDs.addFcm(fcm, token);
  }
}
