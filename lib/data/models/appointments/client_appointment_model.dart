class ClientAppointmentModel {
  final String id;
  final String appointmentDate;
  final String startTime;
  final String endTime;
  final String status;
  final String coachId;
  final String coachProfile;
  final String coachName;
  final String coachProfession;
  ClientAppointmentModel({
    required this.id,
    required this.appointmentDate,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.coachId,
    required this.coachProfile,
    required this.coachName,
    required this.coachProfession,
  });

  factory ClientAppointmentModel.fromJson(Map<String, dynamic> json) {
    return ClientAppointmentModel(
      id: json['id'] as String,
      appointmentDate: json['appointment_date'] as String,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      status: json['status'] as String,
      coachId: json['coach']['user']['id'] as String,
      coachProfile:
          json['coach']['user']['profile_picture_url'] as String? ?? '',
      coachName: json['coach']['user']['username'] as String? ?? '',
      coachProfession: json['coach']['profession'] as String? ?? '',
    );
  }
}

class ClientAppointmentsModel {
  final List<ClientAppointmentModel> appointments;

  ClientAppointmentsModel({required this.appointments});

  factory ClientAppointmentsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as List<dynamic>?;
    return ClientAppointmentsModel(
      appointments: data != null
          ? data
              .map((e) =>
                  ClientAppointmentModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
    );
  }
}
