import 'package:filtrek_app/end_points.dart';
import 'package:filtrek_app/core/class/crud.dart';
import 'package:filtrek_app/data/models/appointments/client_appointment_model.dart';
import 'package:filtrek_app/data/models/appointments/coach_available_slots_model.dart';
import 'package:filtrek_app/data/models/appointments/make_appoitmnet_request_model.dart';

class AppointmentRemoteDs {
  final Crud crud;

  AppointmentRemoteDs({required this.crud});
  Future<ClientAppointmentsModel> getCurrentMemberShip(
      String accessToken) async {
    return ClientAppointmentsModel.fromJson(await crud.getData(
        EndPoints.getUserappointment,
        {'authorization': 'Bearer $accessToken'}));
  }

  Future<CoachAvailableSlotsModel> getCoachAvailableTime(
      String coachId, String day) async {
    var endpoint =
        EndPoints.getCoachAvailableSlots.replaceFirst(":coachId", coachId);
    var fullEndpoint = "${endpoint}?date=$day";
    print('Requesting coach available slots from: $fullEndpoint');
    return CoachAvailableSlotsModel.fromJson(await crud.getData(fullEndpoint));
  }

  makeAppointment(MakeAppoitmnetRequestModel data, String accessToken) async {
    ClientAppointmentsModel.fromJson(await crud.postData(
        EndPoints.makeAppointment,
        {"date": data.date, "slotTime": data.slot, "coachId": data.coachId},
        {'authorization': 'Bearer $accessToken'}));
  }
}
