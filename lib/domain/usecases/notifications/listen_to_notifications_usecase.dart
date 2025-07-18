import 'package:filtrek_app/domain/entities/notification/get_all_notification_entity.dart';
import 'package:filtrek_app/domain/repositories/notification_repository.dart';

class ListenToNotificationsUsecase {
  final NotificationRepository repo;
  ListenToNotificationsUsecase(this.repo);

  Stream<NotificationEntity> execute() => repo.listenNew();
}
