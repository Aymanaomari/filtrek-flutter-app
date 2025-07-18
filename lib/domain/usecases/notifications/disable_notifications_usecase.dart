import 'package:filtrek_app/domain/repositories/notification_repository.dart';

class DisableNotificationsUsecase {
  final NotificationRepository repository;
  DisableNotificationsUsecase(this.repository);

  Future<void> call() async {
    await repository.disableNotifications();
  }
}
