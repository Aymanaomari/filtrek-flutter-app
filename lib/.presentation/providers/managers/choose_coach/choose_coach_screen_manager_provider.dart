import 'dart:async';

import 'package:filtrek_app/core/exceptions/network_exception.dart';
import 'package:filtrek_app/domain/usecases/gym/get_available_coaches_usecase.dart';
import 'package:filtrek_app/presentation/providers/gym_provider.dart';
import 'package:filtrek_app/presentation/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'choose_coach_screen_state.dart';

class ChooseCoachScreenManager extends StateNotifier<ChooseCoachScreenState> {
  final GetAvailableCoachesUsecase _availableCoachesUsecase;
  final String gymId;

  ChooseCoachScreenManager(this._availableCoachesUsecase, this.gymId)
      : super(ChooseCoachScreenState()) {
    fetchAvailableCoaches();
  }

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void setError(String? error) {
    state = state.copyWith(error: error);
  }

  void setAvailableCoachesEntity(availableCoachesEntity) {
    state = state.copyWith(availableCoachesEntity: availableCoachesEntity);
  }

  void selectCoach(String coachId) {
    state = state.copyWith(selectedCoachId: coachId);
  }

  void setSelectedCoach(String coachId) {
    state = state.copyWith(selectedCoachId: coachId);
  }

  Future<void> fetchAvailableCoaches() async {
    setLoading(true);
    setError(null);
    try {
      final entity = await _availableCoachesUsecase.call(gymId);
      setAvailableCoachesEntity(entity);
    } on NetworkException {
      rethrow;
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }
}

final getAvailableCoachesUsecaseProvider = Provider<GetAvailableCoachesUsecase>(
    (ref) => GetAvailableCoachesUsecase(
        gymRepository: ref.read(gymRepositoryProvider)));

final chooseCoachScreenManagerProvider = StateNotifierProvider.autoDispose<
    ChooseCoachScreenManager, ChooseCoachScreenState>(
  (ref) {
    final userState = ref.read(userStateProvider);
    String gymId = userState.currentUserMembership!.gymId;

    final link = ref.keepAlive();
    final timer = Timer(const Duration(seconds: 12), () {
      link.close();
    });

    ref.onDispose(() {
      timer.cancel();
    });

    return ChooseCoachScreenManager(
        ref.read(getAvailableCoachesUsecaseProvider), gymId);
  },
);
