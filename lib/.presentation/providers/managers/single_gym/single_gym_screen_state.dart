import 'package:filtrek_app/domain/entities/gym/single_gym_entity.dart';
import 'package:flutter/material.dart';

class SingleGymScreenState {
  final bool isLoading;
  final String? errorMessage;
  final SingleGymEntity? data;
  final TabController? tabController;

  const SingleGymScreenState({
    this.isLoading = false,
    this.errorMessage,
    this.data,
    this.tabController,
  });

  SingleGymScreenState copyWith({
    bool? isLoading,
    String? errorMessage,
    SingleGymEntity? data,
    bool clearError = false,
    TabController? tabController,
  }) {
    return SingleGymScreenState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      data: data ?? this.data,
      tabController: tabController ?? this.tabController,
    );
  }

  // Helper getters
  bool get hasData => data != null;
  bool get hasError => errorMessage != null;
}
