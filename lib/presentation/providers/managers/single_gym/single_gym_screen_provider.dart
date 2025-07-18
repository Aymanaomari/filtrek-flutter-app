import 'dart:async';
import 'dart:io';

import 'package:filtrek_app/core/exceptions/network_exception.dart';
import 'package:filtrek_app/domain/entities/gym/single_gym_entity.dart';
import 'package:filtrek_app/domain/usecases/gym/get_single_gym_usecase.dart';
import 'package:filtrek_app/presentation/providers/gym_provider.dart';
import 'package:filtrek_app/presentation/providers/managers/single_gym/single_gym_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SingleGymScreenNotifier extends StateNotifier<SingleGymScreenState> {
  final GetSingleGymUsecase _getSingleGymUsecase;

  SingleGymScreenNotifier(this._getSingleGymUsecase)
      : super(const SingleGymScreenState());

  void initializeTabController(TickerProvider vsync) {
    final tabController = TabController(length: 2, vsync: vsync);
    state = state.copyWith(tabController: tabController);
  }

  void disposeTabController() {
    state.tabController?.dispose();
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setError(String? error) {
    state = state.copyWith(
      errorMessage: error,
      isLoading: false,
    );
  }

  void setData(SingleGymEntity gym) {
    print('Setting gym data: $gym');
    state = state.copyWith(
      data: gym,
      isLoading: false,
      clearError: true,
    );
    print(
        'State after setData - hasData: ${state.hasData}, data: ${state.data}');
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  void reset() {
    state = const SingleGymScreenState();
  }

  Future<void> loadGym(String gymId) async {
    print('Loading gym with ID: $gymId');
    try {
      // Clear previous data and set loading state
      state = state.copyWith(
        data: null,
        isLoading: true,
        errorMessage: null,
      );

      print('About to call usecase...');
      final gym = await _getSingleGymUsecase.call(gymId);
      print('Gym received from usecase: $gym');
      setData(gym);
      print('setData called successfully');
    } on HttpException catch (e) {
      print('HTTP error in loadGym: ${e.message}');
      setError('Server error: ${e.message}');
    } on NetworkException {
      rethrow;
    } catch (e) {
      print('Error in loadGym: $e');
      setError(e.toString());
    }
  }

  Future<void> refreshGym(String gymId) async {
    await loadGym(gymId);
  }
}

// Provider for the SingleGymScreenNotifier using family for gym-specific instances
final singleGymScreenProvider = StateNotifierProvider.autoDispose
    .family<SingleGymScreenNotifier, SingleGymScreenState, String>(
        (ref, gymId) {
  final notifier =
      SingleGymScreenNotifier(ref.read(getSingleGymUsecaseProvider));
  // Automatically load gym data when provider is created
  WidgetsBinding.instance.addPostFrameCallback((_) {
    notifier.loadGym(gymId);
  });
  return notifier;
});
