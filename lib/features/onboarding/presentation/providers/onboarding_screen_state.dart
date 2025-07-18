import 'package:filtrek_app/core/constant/image_assets.dart';

class OnboardingScreenState {
  final int currentPage;
  final int totalPages;

  OnboardingScreenState({
    required this.currentPage,
    required this.totalPages,
  });

  OnboardingScreenState copyWith({
    int? currentPage,
    int? totalPages,
  }) {
    return OnboardingScreenState(
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  // Static method to get onboarding data
  static List<Map<String, String>> getData() {
    return [
      {
        'title': 'Find Your Spot Gym',
        'description':
            'Skip the guess work. let us guide you to the best gym with everything you need.',
        'image': ImageAssets.onBoarding1,
      },
      {
        'title': 'Track Your Progress',
        'description':
            'Monitor your workouts and see your improvements over time.',
        'image': ImageAssets.onBoarding2,
      },
    ];
  }
}
