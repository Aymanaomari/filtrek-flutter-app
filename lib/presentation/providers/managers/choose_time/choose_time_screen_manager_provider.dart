import 'package:filtrek_app/core/exceptions/http_exception.dart';
import 'package:filtrek_app/core/exceptions/network_exception.dart';
import 'package:filtrek_app/domain/entities/appointment/make_appointment_request_entity.dart';
import 'package:filtrek_app/domain/usecases/appointment/get_coach_available_slots_usecase.dart';
import 'package:filtrek_app/domain/usecases/appointment/make_an_appointment_usecase.dart';
import 'package:filtrek_app/presentation/providers/appointment_provider.dart';
import 'package:filtrek_app/presentation/providers/managers/choose_time/choose_time_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChooseTimeScreenManagerNotifier
    extends StateNotifier<ChooseTimeScreenState> {
  final GetCoachAvailableSlotsUsecase getCoachAvailableSlotsUsecase;
  final MakeAnAppointmentUsecase makeAnAppointmentUsecase;

  ChooseTimeScreenManagerNotifier(ChooseTimeScreenState state,
      this.getCoachAvailableSlotsUsecase, this.makeAnAppointmentUsecase)
      : super(state) {
    if (state.appointmentRequest != null) {
      loadSlots(state.appointmentRequest!.date);
    }
  }

  void goToPreviousMonth() {
    final prevMonth =
        DateTime(state.focusedDay.year, state.focusedDay.month - 1, 1);
    state = state.copyWith(focusedDay: prevMonth);
  }

  void goToNextMonth() {
    final nextMonth =
        DateTime(state.focusedDay.year, state.focusedDay.month + 1, 1);
    state = state.copyWith(focusedDay: nextMonth);
  }

  void setSelectedDate(DateTime date) {
    final dateStr = "${date.year.toString().padLeft(4, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.day.toString().padLeft(2, '0')}";

    state = state.copyWith(
      focusedDay: date,
      appointmentRequest: MakeAppointmentRequestEntity(
        slot: state.appointmentRequest?.slot ?? '',
        coachId: state.appointmentRequest?.coachId ?? '',
        date: dateStr,
      ),
    );
  }

  Future<bool> makeAppointment() async {
    final appointment = state.appointmentRequest;
    if (appointment == null) {
      print('No appointment request found.');
      return false;
    }

    try {
      await makeAnAppointmentUsecase.call(appointment);
      return true;
    } on HttpException catch (e) {
      print('HTTP Exception while making appointment: ${e.toString()}');
      return false;
    } on NetworkException catch (e) {
      print('Network Exception while making appointment: ${e.toString()}');
      return false;
    } catch (e) {
      print('Unexpected error while making appointment: ${e.toString()}');
      return false;
    }
  }

  void setFocusedDay(DateTime date) {
    state = state.copyWith(focusedDay: date);
  }

  void selectSlot(String? slot) {
    if (state.appointmentRequest == null || slot == null) return;

    state = state.copyWith(
      appointmentRequest: MakeAppointmentRequestEntity(
        slot: slot,
        coachId: state.appointmentRequest!.coachId,
        date: state.appointmentRequest!.date,
      ),
    );
  }

  Future<void> loadSlots(String date) async {
    state = state.copyWith(isLoading: true);
    try {
      final slots = await getCoachAvailableSlotsUsecase.call(
        state.appointmentRequest!.coachId,
        date,
      );
      print('Loaded slots: $slots');
      state = state.copyWith(
        availableSlots: slots,
        isLoading: false,
      );
    } on HttpException {
      state = state.copyWith(isLoading: false);
    } on NetworkException {
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }
}

final chooseTimeScreenManagerProvider = StateNotifierProvider.autoDispose
    .family<ChooseTimeScreenManagerNotifier, ChooseTimeScreenState, String>(
        (ref, coachId) {
  // Keep the provider alive for 10 seconds after last use
  final link = ref.keepAlive();
  Future.delayed(const Duration(seconds: 10), link.close);

  return ChooseTimeScreenManagerNotifier(
      ChooseTimeScreenState.initial(coachId: coachId),
      ref.read(getCoachAvailableSlotsUsecaseProvider),
      ref.read(makeAnAppointmentUsecaseProvider));
});
