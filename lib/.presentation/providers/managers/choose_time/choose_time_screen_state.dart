import 'package:filtrek_app/domain/entities/appointment/make_appointment_request_entity.dart';

class ChooseTimeScreenState {
  final DateTime focusedDay;
  final bool isLoading;
  final List<String> availableSlots;
  final MakeAppointmentRequestEntity? appointmentRequest;

  ChooseTimeScreenState({
    required this.focusedDay,
    this.isLoading = false,
    this.availableSlots = const [],
    this.appointmentRequest,
  });

  ChooseTimeScreenState copyWith({
    DateTime? focusedDay,
    bool? isLoading,
    List<String>? availableSlots,
    MakeAppointmentRequestEntity? appointmentRequest,
  }) {
    return ChooseTimeScreenState(
      focusedDay: focusedDay ?? this.focusedDay,
      isLoading: isLoading ?? this.isLoading,
      availableSlots: availableSlots ?? this.availableSlots,
      appointmentRequest: appointmentRequest ?? this.appointmentRequest,
    );
  }

  static ChooseTimeScreenState initial({String coachId = ''}) {
    final now = DateTime.now();
    return ChooseTimeScreenState(
      focusedDay: now,
      isLoading: false,
      availableSlots: const [],
      appointmentRequest: MakeAppointmentRequestEntity(
        slot: '',
        coachId: coachId,
        date: "${now.year.toString().padLeft(4, '0')}-"
            "${now.month.toString().padLeft(2, '0')}-"
            "${now.day.toString().padLeft(2, '0')}",
      ),
    );
  }
}
