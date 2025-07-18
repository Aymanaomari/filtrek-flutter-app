import 'package:filtrek_app/core/exceptions/http_exception.dart';
import 'package:filtrek_app/core/exceptions/network_exception.dart';
import 'package:filtrek_app/domain/usecases/appointment/get_user_appointments_usecase.dart';
import 'package:filtrek_app/presentation/providers/appointment_provider.dart';
import 'package:filtrek_app/presentation/providers/managers/client_plan/client_plan_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientPlanScreenManager extends StateNotifier<ClientPlanScreenState> {
  final GetUserAppointmentsUsecase _getUserAppointmentsUsecase;
  ClientPlanScreenManager(this._getUserAppointmentsUsecase)
      : super(ClientPlanScreenState()) {
    getDataSource();
  }

  getDataSource() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final appointments = await _getUserAppointmentsUsecase.call();
      state = state.copyWith(
        isLoading: false,
        appointments: appointments,
        error: null,
      );
    } on HttpException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'HTTP error: ${e.message}',
      );
    } on NetworkException {
      rethrow;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Unexpected error: $e',
      );
    }
  }

  void setSelectedDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }
}

final clientPlanScreenManagerProvider = StateNotifierProvider.autoDispose<
    ClientPlanScreenManager, ClientPlanScreenState>(
  (ref) => ClientPlanScreenManager(
      ref.read(getCurrentUserAppoitmentsUsecaseProvider)),
);
