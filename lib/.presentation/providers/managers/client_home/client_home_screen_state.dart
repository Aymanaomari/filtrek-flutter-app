import 'package:filtrek_app/domain/entities/appointment/client_appointment_entity.dart';
import 'package:filtrek_app/domain/entities/collective_sessions/recent_collective_sessions_entity.dart';

class ClientHomeScreenState {
  final bool isLoading;
  final String? error;
  final List<ClientAppointmentEntity> appointments;
  final RecentCollectiveSessionsEntity? recentCollectiveSessions;

  ClientHomeScreenState({
    this.isLoading = false,
    this.error,
    this.appointments = const [],
    this.recentCollectiveSessions,
  });

  ClientHomeScreenState copyWith({
    bool? isLoading,
    String? error,
    List<ClientAppointmentEntity>? appointments,
    DateTime? selectedDate,
    RecentCollectiveSessionsEntity? recentCollectiveSessions,
  }) {
    return ClientHomeScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      appointments: appointments ?? this.appointments,
      recentCollectiveSessions:
          recentCollectiveSessions ?? this.recentCollectiveSessions,
    );
  }
}
