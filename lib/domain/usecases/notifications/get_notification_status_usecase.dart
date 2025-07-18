import 'package:filtrek_app/domain/repositories/notification_repository.dart';
import 'package:filtrek_app/data/datasources/local/notifications/notification_local_ds.dart';

class GetNotificationStatusUsecase {
  final NotificationRepository repository;
  GetNotificationStatusUsecase(this.repository);

  Future<NotificationStatus> call() async {
    return await repository.getNotificationStatus();
  }
}
