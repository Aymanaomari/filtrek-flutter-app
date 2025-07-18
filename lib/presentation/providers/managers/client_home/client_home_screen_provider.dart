import 'package:filtrek_app/core/exceptions/http_exception.dart';
import 'package:filtrek_app/core/exceptions/network_exception.dart';
import 'package:filtrek_app/domain/usecases/appointment/get_user_appointments_usecase.dart';
import 'package:filtrek_app/domain/usecases/collective_sessions/get_recent_collective_sessions_usecase.dart';
import 'package:filtrek_app/presentation/providers/appointment_provider.dart';
import 'package:filtrek_app/presentation/providers/collective_sessions_provider.dart';
import 'package:filtrek_app/presentation/providers/managers/client_home/client_home_screen_state.dart';
import 'package:filtrek_app/presentation/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientHomeScreenManager extends StateNotifier<ClientHomeScreenState> {
  final GetUserAppointmentsUsecase _getUserAppointmentsUsecase;
  final GetRecentCollectiveSessionsUsecase _getRecentCollectiveSessionsUsecase;
  final String gymId;

  ClientHomeScreenManager(this._getUserAppointmentsUsecase,
      this._getRecentCollectiveSessionsUsecase, this.gymId)
      : super(ClientHomeScreenState()) {
    print('ClientHomeScreenManager gymId: $gymId');
    loadData();
  }

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await Future.wait([getDataSource(), getRecentCollectiveSessions()]);
    } on NetworkException {
      rethrow;
    } catch (e) {
      state = state.copyWith(error: 'Unexpected error: $e');
    }
    state = state.copyWith(isLoading: false);
  }

  Future<void> getDataSource() async {
    try {
      final appointments = await _getUserAppointmentsUsecase.call();
      state = state.copyWith(
        appointments: appointments,
        error: null,
      );
    } on HttpException catch (e) {
      state = state.copyWith(
        error: 'HTTP error: ${e.message}',
      );
    } on NetworkException {
      rethrow;
    } catch (e) {
      state = state.copyWith(
        error: 'Unexpected error: $e',
      );
    }
  }

  void setSelectedDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  Future<void> getRecentCollectiveSessions() async {
    try {
      print("start getting the recent collective sessions");
      final sessions = await _getRecentCollectiveSessionsUsecase.call(gymId);
      print(sessions.toString());
      state = state.copyWith(
        recentCollectiveSessions: sessions,
        error: null,
      );
    } on HttpException catch (e) {
      state = state.copyWith(
        error: 'HTTP error: ${e.message}',
      );
    } on NetworkException {
      rethrow;
    } catch (e) {
      state = state.copyWith(
        error: 'Unexpected error: $e',
      );
    }
  }
}

final clientHomeScreenManagerProvider =
    StateNotifierProvider<ClientHomeScreenManager, ClientHomeScreenState>(
  (ref) {
    var userState = ref.read(userStateProvider);
    var gymId = userState.currentUserMembership!.gymId;

    return ClientHomeScreenManager(
        ref.read(getCurrentUserAppoitmentsUsecaseProvider),
        ref.read(getRecentCollectiveSessionsUsecaseProvider),
        gymId);
  },
);
