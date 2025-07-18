import 'package:filtrek_app/features/onboarding/presentation/providers/onboarding_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingScreenManagerNotifier
    extends StateNotifier<OnboardingScreenState> {
  OnboardingScreenManagerNotifier()
      : super(OnboardingScreenState(
            currentPage: 0,
            totalPages: OnboardingScreenState.getData().length));

  void nextPage() {
    if (state.currentPage < state.totalPages - 1) {
      state = state.copyWith(currentPage: state.currentPage + 1);
    }
  }

  void previousPage() {
    if (state.currentPage > 0) {
      state = state.copyWith(currentPage: state.currentPage - 1);
    }
  }

  void goToPage(int page) {
    if (page >= 0 && page < state.totalPages) {
      state = state.copyWith(currentPage: page);
    }
  }
}

final onboardingScreenManagerProvider = StateNotifierProvider<
    OnboardingScreenManagerNotifier,
    OnboardingScreenState>((ref) => OnboardingScreenManagerNotifier());
