import 'package:filtrek_app/domain/repositories/notification_repository.dart';

class AddFcmUsecase {
  final NotificationRepository _notificationRepository;

  AddFcmUsecase({required NotificationRepository notificationRepository})
      : _notificationRepository = notificationRepository;

  Future<void> call(String fcm) async {
    await _notificationRepository.addFcmToken(fcm);
  }
}
