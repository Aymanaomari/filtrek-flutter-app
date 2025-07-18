import 'package:filtrek_app/domain/repositories/notification_repository.dart';

class EnableNotificationsUsecase {
  final NotificationRepository repository;
  EnableNotificationsUsecase(this.repository);

  Future<void> call() async {
    await repository.enableNotifications();
  }
}
