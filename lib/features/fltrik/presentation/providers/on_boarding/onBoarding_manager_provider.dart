import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// State class to hold onboarding data
class OnboardingState {
  final int currentIndex;
  final bool isLastPage;
  final PageController pageController;

  OnboardingState({
    required this.currentIndex,
    required this.isLastPage,
    required this.pageController,
  });

  OnboardingState copyWith({
    int? currentIndex,
    bool? isLastPage,
    PageController? pageController,
  }) {
    return OnboardingState(
      currentIndex: currentIndex ?? this.currentIndex,
      isLastPage: isLastPage ?? this.isLastPage,
      pageController: pageController ?? this.pageController,
    );
  }
}

// StateNotifier class
class OnboardingManagerNotifier extends StateNotifier<OnboardingState> {
  OnboardingManagerNotifier()
      : super(OnboardingState(
          currentIndex: 0,
          isLastPage: false,
          pageController: PageController(),
        ));

  // Total number of onboarding pages
  static const int totalPages = 3;

  // Navigate to next page
  void nextPage() {
    if (state.currentIndex < totalPages - 1) {
      final newIndex = state.currentIndex + 1;
      state.pageController.animateToPage(
        newIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _updateIndex(newIndex);
    }
  }

  // Navigate to previous page
  void previousPage() {
    if (state.currentIndex > 0) {
      final newIndex = state.currentIndex - 1;
      state.pageController.animateToPage(
        newIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _updateIndex(newIndex);
    }
  }

  // Jump to specific page
  void jumpToPage(int index) {
    if (index >= 0 && index < totalPages) {
      state.pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _updateIndex(index);
    }
  }

  // Called when page changes (e.g., by swiping)
  void onPageChanged(int index) {
    _updateIndex(index);
  }

  // Update the current index and last page status
  void _updateIndex(int index) {
    state = state.copyWith(
      currentIndex: index,
      isLastPage: index == totalPages - 1,
    );
  }

  // Skip to last page
  void skipToLast() {
    jumpToPage(totalPages - 1);
  }

  // Complete onboarding
  void completeOnboarding() {
    // Add your logic here (e.g., navigate to home, save completion status)
    // This is where you might use GoRouter to navigate to the next screen
  }

  @override
  void dispose() {
    state.pageController.dispose();
    super.dispose();
  }
}

// Provider
final onboardingManagerProvider =
    StateNotifierProvider<OnboardingManagerNotifier, OnboardingState>((ref) {
  return OnboardingManagerNotifier();
});
