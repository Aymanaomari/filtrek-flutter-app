import 'package:filtrek_app/domain/usecases/gym/get_top_gyms_usecase.dart';
import 'package:filtrek_app/presentation/providers/gym_provider.dart';
import 'package:filtrek_app/core/exceptions/http_exception.dart';
import 'package:filtrek_app/core/exceptions/network_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:filtrek_app/presentation/providers/managers/home/home_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreenManagerNotifier extends StateNotifier<HomeScreenState> {
  final GetTopGymsUsecase _getTopGymsUsecase;

  HomeScreenManagerNotifier(this._getTopGymsUsecase)
      : super(HomeScreenState(
          searchController: TextEditingController(),
          isLoadingPosition: true,
          isLoadingTopGyms: false,
        )) {
    _initializePosition();
    _loadTopGyms();
  }

  void _initializePosition() async {
    try {
      final position = await _determinePosition();

      // Log the position coordinates
      print(
          'User Position - Latitude: ${position.latitude}, Longitude: ${position.longitude}');

      state = state.copyWith(
        currentPosition: position,
        isLoadingPosition: false,
        positionError: null,
      );
    } catch (e) {
      debugPrint('Error getting position: ${e.toString()}');
      state = state.copyWith(
        isLoadingPosition: false,
        positionError: e.toString(),
      );
    }
  }

  // Getter to access current position
  Position? get currentPosition => state.currentPosition;
  bool get isLoadingPosition => state.isLoadingPosition;
  String? get positionError => state.positionError;

  // Method to refresh position
  Future<void> refreshPosition() async {
    state = state.copyWith(isLoadingPosition: true, positionError: null);
    _initializePosition();
  }

  // Public method to reload all data
  Future<void> reloadData() async {
    await Future.wait([
      refreshPosition(),
      Future(() => _loadTopGyms()),
    ]);
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void _loadTopGyms() async {
    state = state.copyWith(isLoadingTopGyms: true, topGymsError: null);

    try {
      final result = await _getTopGymsUsecase.call();
      print(result.toString());
      state = state.copyWith(
        topGyms: result,
        isLoadingTopGyms: false,
        topGymsError: null,
      );
    } on HttpException catch (e) {
      debugPrint('HTTP error loading top gyms: ${e.message}');
      state = state.copyWith(
        isLoadingTopGyms: false,
        topGymsError: 'Server error: ${e.message}',
      );
    } on NetworkException {
      rethrow;
    } catch (e) {
      debugPrint('Unexpected error loading top gyms: ${e.toString()}');
      state = state.copyWith(
        isLoadingTopGyms: false,
        topGymsError: 'Failed to load top gyms: ${e.toString()}',
      );
    }
  }
}

final homeScreenManagerProvider =
    StateNotifierProvider<HomeScreenManagerNotifier, HomeScreenState>(
  (ref) => HomeScreenManagerNotifier(ref.read(getTopGymUsecaseProvider)),
);
