import 'dart:async';

import 'package:filtrek_app/core/exceptions/http_exception.dart';
import 'package:filtrek_app/core/exceptions/network_exception.dart';
import 'package:filtrek_app/domain/entities/gym/gym_entity.dart';
import 'package:filtrek_app/domain/entities/gym/gyms_response_entity.dart';
import 'package:filtrek_app/domain/usecases/gym/get_all_gyms_usecase.dart';
import 'package:filtrek_app/domain/usecases/gym/get_available_gym_cities_usecase.dart';
import 'package:filtrek_app/presentation/providers/gym_provider.dart';
import 'package:filtrek_app/presentation/providers/managers/search/search_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreenManagerNotifier extends StateNotifier<SearchScreenState> {
  final GetAllGymsUsecase _allGymsUsecase;
  final GetAvailabeGymCitiesUsecase _availabeGymCitiesUsecase;

  SearchScreenManagerNotifier(
      this._allGymsUsecase, this._availabeGymCitiesUsecase)
      : super(SearchScreenState()) {
    loadGyms();
    loadAvailableGymsCities();
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setAvailableCitiesLoading(bool loading) {
    state = state.copyWith(availableCitiesAreLoading: loading);
  }

  void setError(String? error) {
    state = state.copyWith(errorMessage: error);
  }

  void setData({
    required List<GymEntity> data,
    required int total,
    required int page,
    required int limit,
    required bool hasNextPage,
  }) {
    state = state.copyWith(
      data: data,
      total: total,
      page: page,
      limit: limit,
      hasNextPage: hasNextPage,
      isLoading: false,
      errorMessage: null,
    );
  }

  void nextPage() {
    if (state.hasNextPage) {
      state = state.copyWith(page: state.page + 1);
    }
  }

  void resetToFirstPage() {
    state = state.copyWith(
      page: 1,
      data: [],
      total: 0,
      hasNextPage: false,
    );
  }

  void setShowingStyle(String style) {
    state = state.copyWith(showingStyle: style);
  }

  // Filter management methods
  void updateCityFilter(String city) {
    state.cityController.text = city;
  }

  void updateMinPrice(String minPrice) {
    state.minPriceController.text = minPrice;
  }

  void updateMaxPrice(String maxPrice) {
    state.maxPriceController.text = maxPrice;
  }

  void resetFilters() {
    state.cityController.clear();
    state.minPriceController.clear();
    state.maxPriceController.clear();
  }

  void applyFilters() {
    // Here you would typically call the API with filter parameters
    // For now, just reload the gyms
    loadGyms();
  }

  Future<void> loadGyms() async {
    try {
      setLoading(true);
      setError(null);

      int? minPrice = state.minPriceController.text.isNotEmpty
          ? int.tryParse(state.minPriceController.text)
          : null;
      int? maxPrice = state.maxPriceController.text.isNotEmpty
          ? int.tryParse(state.maxPriceController.text)
          : null;
      String? name = state.searchController.text.isNotEmpty
          ? state.searchController.text
          : null;

      final GymsResponseEntity result = await _allGymsUsecase.call(
        page: state.page,
        limit: state.limit,
        minPrice: minPrice,
        maxPrice: maxPrice,
        name: name,
      );

      setData(
        data: result.data,
        total: result.total,
        page: result.page,
        limit: result.limit,
        hasNextPage: result.hasNextPage,
      );
    } on HttpException catch (e) {
      setError('Server error: ${e.message}');
    } on NetworkException {
      rethrow;
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> loadAvailableGymsCities() async {
    try {
      setAvailableCitiesLoading(true);
      final cities = await _availabeGymCitiesUsecase.call();

      state = state.copyWith(availableGymsCities: cities);
    } on HttpException catch (e) {
      setError('Server error: ${e.message}');
    } on NetworkException {
      rethrow;
    } catch (e) {
      setError(e.toString());
    } finally {
      setAvailableCitiesLoading(false);
    }
  }
}

final searchScreenManagerProvider =
    StateNotifierProvider<SearchScreenManagerNotifier, SearchScreenState>(
        (ref) {
  return SearchScreenManagerNotifier(ref.read(getAllGymsUsecaseProvider),
      ref.read(getAvailableGymCitiesProvider));
});
