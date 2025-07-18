import 'package:filtrek_app/core/class/crud.dart';
import 'package:filtrek_app/core/class/firebase_fcm_servicer.dart';
import 'package:filtrek_app/core/class/local_notifications_service.dart';
import 'package:filtrek_app/data/datasources/remote/notifications_ds.dart';
import 'package:filtrek_app/data/datasources/local/notifications/notification_local_ds.dart';
import 'package:filtrek_app/data/repositories/notifications_repository_imp.dart';
import 'package:filtrek_app/domain/entities/notification/get_all_notification_entity.dart';
import 'package:filtrek_app/domain/repositories/notification_repository.dart';
import 'package:filtrek_app/domain/usecases/notifications/add_fcm_usecase.dart';
import 'package:filtrek_app/domain/usecases/notifications/get_notifications_usecase.dart';
import 'package:filtrek_app/domain/usecases/notifications/listen_to_notifications_usecase.dart';
import 'package:filtrek_app/domain/usecases/notifications/enable_notifications_usecase.dart';
import 'package:filtrek_app/domain/usecases/notifications/disable_notifications_usecase.dart';
import 'package:filtrek_app/domain/usecases/notifications/get_notification_status_usecase.dart';
import 'package:filtrek_app/presentation/providers/membership_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:filtrek_app/core/exceptions/network_exception.dart';

class NotificationState {
  final AllNotificationsEntity notifications;
  final bool isLoading;
  final String? error;
  final bool notificationEnabled;

  NotificationState({
    required this.notifications,
    this.isLoading = false,
    this.error,
    this.notificationEnabled = true,
  });

  NotificationState copyWith({
    AllNotificationsEntity? notifications,
    bool? isLoading,
    String? error,
    bool? notificationEnabled,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      notificationEnabled: notificationEnabled ?? this.notificationEnabled,
    );
  }
}

class NotificationNotifier extends StateNotifier<NotificationState> {
  final GetNotificationsUsecase _getNotificationsUsecase;
  final ListenToNotificationsUsecase _listenToNotificationsUsecase;
  final EnableNotificationsUsecase _enableNotificationsUsecase;
  final DisableNotificationsUsecase _disableNotificationsUsecase;
  final GetNotificationStatusUsecase _getNotificationStatusUsecase;
  final AddFcmUsecase _addFcmUsecase;

  NotificationNotifier(
    this._getNotificationsUsecase,
    this._listenToNotificationsUsecase,
    this._enableNotificationsUsecase,
    this._disableNotificationsUsecase,
    this._getNotificationStatusUsecase,
    this._addFcmUsecase,
  ) : super(NotificationState(
            notifications: AllNotificationsEntity(notifications: []))) {
    getAllNotifications();
    listenToNotifications();
    addFcmToken();
  }

  Future<void> addFcmToken() async {
    try {
      await LocalNotificationsService.init();
      await FirebaseFcmService.init();
      await _addFcmUsecase.call(FirebaseFcmService.fcmToken!);
    } on NetworkException {
      rethrow;
    } catch (e) {
      setError("Failed to add FCM token: $e");
    }
  }

  void clearState() {
    state = NotificationState(
      notifications: AllNotificationsEntity(notifications: []),
      isLoading: false,
      error: null,
      notificationEnabled: true,
    );
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setNotifications(AllNotificationsEntity notifications) {
    state = state.copyWith(notifications: notifications, isLoading: false);
  }

  void setError(String error) {
    state = state.copyWith(error: error, isLoading: false);
  }

  void addNotification(NotificationEntity notification) {
    final notificationsList = [
      ...state.notifications.notifications,
      notification
    ];
    state = state.copyWith(
      notifications: AllNotificationsEntity(notifications: notificationsList),
    );
  }

  Future<void> getAllNotifications() async {
    setLoading(true);
    try {
      final result = await _getNotificationsUsecase.execute();
      setNotifications(result);
    } catch (e) {
      setError(e.toString());
    }
  }

  void listenToNotifications() {
    final stream = _listenToNotificationsUsecase.execute();
    stream.listen((notification) {
      addNotification(notification);
      final int notificationIntId = notification.id.hashCode;
      LocalNotificationsService.showBasicNotification(
          id: notificationIntId,
          title: notification.notificationType.name,
          message: notification.message);
    });
  }

  Future<void> enableNotifications() async {
    await _enableNotificationsUsecase.call();
    state = state.copyWith(notificationEnabled: true);
  }

  Future<void> disableNotifications() async {
    await _disableNotificationsUsecase.call();
    state = state.copyWith(notificationEnabled: false);
  }

  Future<void> loadNotificationStatus() async {
    final status = await _getNotificationStatusUsecase.call();
    state = state.copyWith(
        notificationEnabled: status == NotificationStatus.enabled);
  }

  Future<void> reload() async {
    clearState();
    await getAllNotifications();
    listenToNotifications();
    await loadNotificationStatus();
    await addFcmToken();
  }
}

final notificationRemoteDsProvider =
    Provider<NotificationRemoteDs>((ref) => NotificationRemoteDs(crud: Crud()));

final notificationLocalDsProvider =
    Provider<NotificationLocalDs>((ref) => NotificationLocalDs());

final notificationRepoProvider = Provider<NotificationRepository>((ref) {
  final repo = NotificationRepositoryImpl(
    ref.read(authLocalDataSourceProvider),
    ref.read(notificationRemoteDsProvider),
    ref.read(notificationLocalDsProvider),
  );
  Future.delayed(const Duration(seconds: 5), () {
    ref.invalidateSelf();
  });
  return repo;
});

final getNotificationsUsecaseProvider =
    Provider<GetNotificationsUsecase>((ref) {
  return GetNotificationsUsecase(ref.read(notificationRepoProvider));
});

final listenToNotificationsUsecaseProvider =
    Provider<ListenToNotificationsUsecase>((ref) {
  return ListenToNotificationsUsecase(ref.read(notificationRepoProvider));
});

final enableNotificationsUsecaseProvider =
    Provider<EnableNotificationsUsecase>((ref) {
  return EnableNotificationsUsecase(ref.read(notificationRepoProvider));
});

final disableNotificationsUsecaseProvider =
    Provider<DisableNotificationsUsecase>((ref) {
  return DisableNotificationsUsecase(ref.read(notificationRepoProvider));
});

final getNotificationStatusUsecaseProvider =
    Provider<GetNotificationStatusUsecase>((ref) {
  return GetNotificationStatusUsecase(ref.read(notificationRepoProvider));
});

final addFcmUsecaseProvider = Provider<AddFcmUsecase>((ref) =>
    AddFcmUsecase(notificationRepository: ref.read(notificationRepoProvider)));

final notificationProvider =
    StateNotifierProvider.autoDispose<NotificationNotifier, NotificationState>(
        (ref) {
  final getNotificationsUsecase = ref.read(getNotificationsUsecaseProvider);
  final listenToNotificationsUsecase =
      ref.read(listenToNotificationsUsecaseProvider);
  final enableNotificationsUsecase =
      ref.read(enableNotificationsUsecaseProvider);
  final disableNotificationsUsecase =
      ref.read(disableNotificationsUsecaseProvider);
  final getNotificationStatusUsecase =
      ref.read(getNotificationStatusUsecaseProvider);
  final addFcmUsecase = ref.read(addFcmUsecaseProvider);

  // Keep the provider alive for 10 seconds after last use
  final link = ref.keepAlive();
  Future.delayed(const Duration(seconds: 10), () {
    link.close();
  });

  return NotificationNotifier(
      getNotificationsUsecase,
      listenToNotificationsUsecase,
      enableNotificationsUsecase,
      disableNotificationsUsecase,
      getNotificationStatusUsecase,
      addFcmUsecase);
});
