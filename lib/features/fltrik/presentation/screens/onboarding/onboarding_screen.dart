import 'package:filtrek_app/features/fltrik/core/constant/colors_assets.dart';
import 'package:filtrek_app/features/fltrik/core/constant/image_assets.dart';
import 'package:filtrek_app/features/fltrik/core/theme/app_typography.dart';
import 'package:filtrek_app/features/fltrik/presentation/providers/on_boarding/onBoarding_manager_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageState = ref.watch(onboardingManagerProvider);
    final pageNotifider = ref.read(onboardingManagerProvider.notifier);

    return Scaffold(
        body: Container(
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Image.asset(
                    ImageAssets.onBoarding1,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 50,
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: -50,
                          left: -100, // Extend beyond left edge
                          right: -100, // Extend beyond right edge
                          height: 100,
                          child: Transform.rotate(
                            angle: -0.2,
                            child: Container(
                              color: ColorsAssets.secondaryColor,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 20,
                          right: 20,
                          child: Container(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text("Meet Your coach",
                                      style: AppTypography.subtitle1.copyWith(
                                          color: ColorsAssets.textLight)),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8)),
                                  Text(
                                    "Start Your journey",
                                    style: AppTypography.h1.copyWith(
                                        color: ColorsAssets.primaryColor),
                                    textAlign: TextAlign.center,
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 32.0)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    spacing: 8.0,
                                    children: List.generate(3, (int index) {
                                      return pageState.currentIndex == index
                                          ? Container(
                                              height: 4,
                                              width: 32,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(99)),
                                                color:
                                                    ColorsAssets.primaryColor,
                                              ),
                                            )
                                          : Container(
                                              height: 4,
                                              width: 16,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(99)),
                                                color:
                                                    ColorsAssets.textMediumDark,
                                              ),
                                            );
                                    }),
                                  )
                                ],
                              )),
                        ),
                      ],
                    )),
              ],
            )));
  }
}
