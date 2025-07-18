import 'package:filtrek_app/features/authentication/data/datasources/local/auth_local_datasource.dart';
import 'package:filtrek_app/data/datasources/remote/appointment_remote_ds.dart';
import 'package:filtrek_app/data/models/appointments/client_appointment_model.dart';
import 'package:filtrek_app/domain/entities/appointment/client_appointment_entity.dart';
import 'package:filtrek_app/domain/entities/appointment/make_appointment_request_entity.dart';
import 'package:filtrek_app/domain/repositories/appointments_repository.dart';

class AppointmentsRepositoryImp implements AppointmentsRepository {
  final AuthLocalDataSource _authLocalDs;
  final AppointmentRemoteDs _appointmentRemoteDs;

  AppointmentsRepositoryImp(
      {required AuthLocalDataSource authLocalDs,
      required AppointmentRemoteDs appointmentRemoteDs})
      : _authLocalDs = authLocalDs,
        _appointmentRemoteDs = appointmentRemoteDs;

  @override
  Future<List<ClientAppointmentEntity>> getCurrentUserAppointments() async {
    String? accessToken = await _authLocalDs.getAccessToken();
    if (accessToken == null || accessToken.isEmpty) {
      return [];
    }
    ClientAppointmentsModel data =
        await _appointmentRemoteDs.getCurrentMemberShip(accessToken);

    // Map each model to entity
    return data.appointments.map((model) {
      final from =
          DateTime.parse("${model.appointmentDate}T${model.startTime}");
      final to = DateTime.parse("${model.appointmentDate}T${model.endTime}");
      return ClientAppointmentEntity(from, to, model.coachId, model.id, "",
          model.coachProfile, model.coachName, model.coachProfession

          // clientId, adjust if available in model
          );
    }).toList();
  }

  @override
  Future<List<String>> getCoachAvailableTimes(
      String coachId, String day) async {
    var response =
        await this._appointmentRemoteDs.getCoachAvailableTime(coachId, day);
    return response.slots;
  }

  @override
  makeAppointment(MakeAppointmentRequestEntity data) async {
    String? accessToken = await _authLocalDs.getAccessToken();
    if (accessToken == null || accessToken.isEmpty) {
      throw Exception('Access token is missing');
    }
    await _appointmentRemoteDs.makeAppointment(data.toModel(), accessToken);
  }
}
