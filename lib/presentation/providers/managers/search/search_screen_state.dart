import 'package:filtrek_app/domain/entities/gym/gym_entity.dart';
import 'package:flutter/material.dart';

class SearchScreenState {
  final int total;
  final int page;
  final int limit;
  final bool hasNextPage;
  final List<GymEntity> data;
  final bool isLoading;
  final String? errorMessage;
  final String showingStyle;
  final TextEditingController cityController;
  final TextEditingController minPriceController;
  final TextEditingController maxPriceController;
  final List<String> availableCities;
  final TextEditingController searchController;
  final List<String> availableGymsCities;
  final bool availableCitiesAreLoading;

  SearchScreenState({
    this.total = 0,
    this.page = 1,
    this.limit = 10,
    this.hasNextPage = false,
    this.data = const [],
    this.isLoading = false,
    this.errorMessage,
    this.showingStyle = "grid",
    this.availableCities = const [],
    this.availableGymsCities = const [],
    TextEditingController? cityController,
    TextEditingController? minPriceController,
    TextEditingController? maxPriceController,
    TextEditingController? searchController,
    this.availableCitiesAreLoading = false,
  })  : cityController = cityController ?? TextEditingController(),
        minPriceController = minPriceController ?? TextEditingController(),
        maxPriceController = maxPriceController ?? TextEditingController(),
        searchController = searchController ?? TextEditingController();

  SearchScreenState copyWith({
    int? total,
    int? page,
    int? limit,
    bool? hasNextPage,
    List<GymEntity>? data,
    bool? isLoading,
    String? errorMessage,
    String? showingStyle,
    List<String>? availableCities,
    List<String>? availableGymsCities,
    TextEditingController? cityController,
    TextEditingController? minPriceController,
    TextEditingController? maxPriceController,
    TextEditingController? searchController,
    bool? availableCitiesAreLoading,
  }) {
    return SearchScreenState(
      total: total ?? this.total,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      showingStyle: showingStyle ?? this.showingStyle,
      availableCities: availableCities ?? this.availableCities,
      availableGymsCities: availableGymsCities ?? this.availableGymsCities,
      cityController: cityController ?? this.cityController,
      minPriceController: minPriceController ?? this.minPriceController,
      maxPriceController: maxPriceController ?? this.maxPriceController,
      searchController: searchController ?? this.searchController,
      availableCitiesAreLoading:
          availableCitiesAreLoading ?? this.availableCitiesAreLoading,
    );
  }
}
