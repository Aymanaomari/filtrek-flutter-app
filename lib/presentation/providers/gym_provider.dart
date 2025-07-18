import 'package:filtrek_app/core/class/crud.dart';
import 'package:filtrek_app/data/datasources/remote/gym_remote_ds.dart';
import 'package:filtrek_app/data/repositories/gym_repository_imp.dart';
import 'package:filtrek_app/domain/repositories/gym_repository.dart';
import 'package:filtrek_app/domain/usecases/gym/get_all_gyms_usecase.dart';
import 'package:filtrek_app/domain/usecases/gym/get_available_gym_cities_usecase.dart';
import 'package:filtrek_app/domain/usecases/gym/get_single_gym_usecase.dart';
import 'package:filtrek_app/domain/usecases/gym/get_top_gyms_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gymRemoteDsProvider =
    Provider<GymRemoteDs>((ref) => GymRemoteDs(crud: Crud()));

final gymRepositoryProvider = Provider<GymRepository>(
    (ref) => GymRepositoryImp(gymRemoteDs: ref.read(gymRemoteDsProvider)));

final getAllGymsUsecaseProvider = Provider<GetAllGymsUsecase>(
    (ref) => GetAllGymsUsecase(gymRepository: ref.read(gymRepositoryProvider)));

final getSingleGymUsecaseProvider = Provider<GetSingleGymUsecase>((ref) {
  return GetSingleGymUsecase(gymRepository: ref.read(gymRepositoryProvider));
});

final getTopGymUsecaseProvider = Provider<GetTopGymsUsecase>((ref) {
  return GetTopGymsUsecase(gymRepository: ref.read(gymRepositoryProvider));
});

final getAvailableGymCitiesProvider = Provider<GetAvailabeGymCitiesUsecase>(
    (ref) => GetAvailabeGymCitiesUsecase(
        gymRepository: ref.read(gymRepositoryProvider)));
