import 'package:filtrek_app/domain/entities/user/current_user_response_entity.dart';
import 'package:filtrek_app/domain/entities/gym/top_gym_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreenState {
  final TextEditingController searchController;
  final Position? currentPosition;
  final bool isLoadingPosition;
  final String? positionError;
  final TopGymEntity? topGyms;
  final bool isLoadingTopGyms;
  final String? topGymsError;

  HomeScreenState({
    required this.searchController,
    this.currentPosition,
    this.isLoadingPosition = false,
    this.positionError,
    this.topGyms,
    this.isLoadingTopGyms = false,
    this.topGymsError,
  });

  HomeScreenState copyWith({
    CurrentUserResponseEntity? currentUser,
    TextEditingController? searchController,
    Position? currentPosition,
    bool? isLoadingPosition,
    String? positionError,
    TopGymEntity? topGyms,
    bool? isLoadingTopGyms,
    String? topGymsError,
  }) {
    return HomeScreenState(
      searchController: searchController ?? this.searchController,
      currentPosition: currentPosition ?? this.currentPosition,
      isLoadingPosition: isLoadingPosition ?? this.isLoadingPosition,
      positionError: positionError ?? this.positionError,
      topGyms: topGyms ?? this.topGyms,
      isLoadingTopGyms: isLoadingTopGyms ?? this.isLoadingTopGyms,
      topGymsError: topGymsError ?? this.topGymsError,
    );
  }
}
