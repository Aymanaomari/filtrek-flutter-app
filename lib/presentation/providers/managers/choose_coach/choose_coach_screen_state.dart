import 'package:filtrek_app/domain/entities/gym/available_coaches_entity.dart';

class ChooseCoachScreenState {
  final bool isLoading;
  final String? error;
  final AvailableCoachesEntity? availableCoachesEntity;
  final String? selectedCoachId;

  ChooseCoachScreenState({
    this.isLoading = false,
    this.error,
    this.availableCoachesEntity,
    this.selectedCoachId,
  });

  ChooseCoachScreenState copyWith({
    bool? isLoading,
    String? error,
    AvailableCoachesEntity? availableCoachesEntity,
    String? selectedCoachId,
  }) {
    return ChooseCoachScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      availableCoachesEntity:
          availableCoachesEntity ?? this.availableCoachesEntity,
      selectedCoachId: selectedCoachId ?? this.selectedCoachId,
    );
  }
}
