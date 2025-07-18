import 'package:filtrek_app/core/class/crud.dart';
import 'package:filtrek_app/data/datasources/remote/appointment_remote_ds.dart';
import 'package:filtrek_app/data/repositories/appointments_repository_imp.dart';
import 'package:filtrek_app/domain/repositories/appointments_repository.dart';
import 'package:filtrek_app/domain/usecases/appointment/get_coach_available_slots_usecase.dart';
import 'package:filtrek_app/domain/usecases/appointment/get_user_appointments_usecase.dart';
import 'package:filtrek_app/domain/usecases/appointment/make_an_appointment_usecase.dart';
import 'package:filtrek_app/presentation/providers/membership_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appointmentRemoteDataSourceProvider =
    Provider<AppointmentRemoteDs>((ref) => AppointmentRemoteDs(crud: Crud()));

final appoitmentRepositoryProvider = Provider<AppointmentsRepository>((ref) =>
    AppointmentsRepositoryImp(
        authLocalDs: ref.read(authLocalDataSourceProvider),
        appointmentRemoteDs: ref.read(appointmentRemoteDataSourceProvider)));

final getCurrentUserAppoitmentsUsecaseProvider =
    Provider<GetUserAppointmentsUsecase>((ref) => GetUserAppointmentsUsecase(
        appointmentsRepository: ref.read(appoitmentRepositoryProvider)));

final getCoachAvailableSlotsUsecaseProvider =
    Provider<GetCoachAvailableSlotsUsecase>((ref) =>
        GetCoachAvailableSlotsUsecase(
            appointmentsRepository: ref.read(appoitmentRepositoryProvider)));
final makeAnAppointmentUsecaseProvider = Provider<MakeAnAppointmentUsecase>(
    (ref) => MakeAnAppointmentUsecase(
        appointmentsRepository: ref.read(appoitmentRepositoryProvider)));
