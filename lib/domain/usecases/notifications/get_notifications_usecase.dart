import 'package:filtrek_app/domain/entities/notification/get_all_notification_entity.dart';
import 'package:filtrek_app/domain/repositories/notification_repository.dart';

class GetNotificationsUsecase {
  final NotificationRepository repo;
  GetNotificationsUsecase(this.repo);

  Future<AllNotificationsEntity> execute() => repo.fetchAll();
}
