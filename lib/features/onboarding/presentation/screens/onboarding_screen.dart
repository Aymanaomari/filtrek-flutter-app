import 'package:filtrek_app/core/utils/extensions.dart';
import 'package:filtrek_app/features/authentication/presentation/screens/singin_screen.dart';
import 'package:filtrek_app/features/onboarding/presentation/providers/onboarding_screen_state.dart';
import 'package:filtrek_app/features/onboarding/presentation/widgets/left_diagonal_image.dart';
import 'package:filtrek_app/features/shared/widgets/app_button.dart';
import 'package:filtrek_app/features/shared/widgets/app_button_two.dart';
import 'package:flutter/material.dart';
import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:filtrek_app/features/onboarding/presentation/providers/onboarding_screen_manager_provider.dart';

class OnBoardingScreen extends ConsumerStatefulWidget {
  static const String routeName = '/onBoarding';
  static const String routePath = '/onBoarding';

  const OnBoardingScreen({super.key});

  @override
  ConsumerState<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends ConsumerState<OnBoardingScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    final onboardingState = ref.watch(onboardingScreenManagerProvider);
    final onboardingNotifier =
        ref.read(onboardingScreenManagerProvider.notifier);
    final isLastPage =
        onboardingState.currentPage == onboardingState.totalPages - 1;
    final onboardingData =
        OnboardingScreenState.getData()[onboardingState.currentPage];

    final color = Theme.of(context).colorScheme;

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          LeftDiagonalImage(
            imagePath: onboardingData['image']!,
            height: 50.0.hp(context),
          ),
          Expanded(
            child: Container(
              color: color.surface,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 36,
                  ),
                  TweenAnimationBuilder(
                      key: ValueKey('title_${onboardingState.currentPage}'),
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(seconds: 1),
                      child: Text(onboardingData['title']!,
                          textAlign: TextAlign.center,
                          style: AppTypography.h1.copyWith(
                            color: color.primary,
                          )),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: child,
                        );
                      }),
                  const SizedBox(height: 8),
                  TweenAnimationBuilder(
                      key: ValueKey('desc_${onboardingState.currentPage}'),
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(seconds: 1),
                      child: Text(
                        onboardingData['description']!,
                        textAlign: TextAlign.center,
                        style: AppTypography.body2.copyWith(
                          color: color.onSecondary,
                        ),
                      ),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: child,
                        );
                      }),
                  const SizedBox(height: 30),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                    child: Row(
                      key: ValueKey(onboardingState.currentPage),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          List.generate(onboardingState.totalPages, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: onboardingState.currentPage == index
                              ? Container(
                                  width: 32,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: color.primary,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                )
                              : Container(
                                  width: 24,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: color.secondary,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (isLastPage)
                    SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: AppButton(
                          text: "Start Now",
                          onPressed: () {
                            context.goNamed(SigninScreen.routeName);
                          },
                        ))
                  else ...[
                    SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: AppButton(
                          text: "Next",
                          onPressed: () {
                            onboardingNotifier.nextPage();
                          },
                        )),
                    const SizedBox(height: 16),
                    AppButtonTwo(
                      text: "Skip",
                      onPressed: () {
                        context.goNamed(SigninScreen.routeName);
                      },
                    )
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
