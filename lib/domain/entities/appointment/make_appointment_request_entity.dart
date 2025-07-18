import 'package:filtrek_app/data/models/appointments/make_appoitmnet_request_model.dart';

class MakeAppointmentRequestEntity {
  final String slot;
  final String coachId;
  final String date;

  MakeAppointmentRequestEntity({
    required this.slot,
    required this.coachId,
    required this.date,
  });

  MakeAppoitmnetRequestModel toModel() {
    return MakeAppoitmnetRequestModel(
      slot: slot,
      coachId: coachId,
      date: date,
    );
  }
}
