import 'package:filtrek_app/domain/entities/appointment/client_appointment_entity.dart';

class ClientPlanScreenState {
  final bool isLoading;
  final String? error;
  final List<ClientAppointmentEntity> appointments;
  final DateTime selectedDate;

  ClientPlanScreenState({
    this.isLoading = false,
    this.error,
    this.appointments = const [],
    DateTime? selectedDate,
  }) : selectedDate = selectedDate ?? DateTime.now();

  ClientPlanScreenState copyWith({
    bool? isLoading,
    String? error,
    List<ClientAppointmentEntity>? appointments,
    DateTime? selectedDate,
  }) {
    return ClientPlanScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      appointments: appointments ?? this.appointments,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
