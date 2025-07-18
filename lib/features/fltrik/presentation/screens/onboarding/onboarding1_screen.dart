import 'package:filtrek_app/route_names.dart';
import 'package:flutter/material.dart';
import 'package:filtrek_app/features/fltrik/core/constant/colors_assets.dart';
import 'package:filtrek_app/features/fltrik/presentation/widgets/onboarding/custom_button.dart';
import 'package:filtrek_app/features/fltrik/presentation/widgets/onboarding/left_diagonal_image.dart';
import 'package:filtrek_app/features/fltrik/core/constant/image_assets.dart';
import 'package:filtrek_app/features/fltrik/core/theme/app_typography.dart';
import 'package:go_router/go_router.dart';

class OnBoardingScreen1 extends StatelessWidget {
  const OnBoardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorsAssets.scaffoldBackground,
      body: Column(
        children: [
            LeftDiagonalImage(
            imagePath: ImageAssets.onBoarding1,
            height: size.height * 0.6,
          ),
          Expanded(
            child: Container(
              color: ColorsAssets.scaffoldBackground,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Find Your Spot Gym',
                    textAlign: TextAlign.center,
                    style: AppTypography.displaySmall.copyWith(
                          color: ColorsAssets.primaryColor, 
                        ),
        
                  ),
                  const SizedBox(height: 8),
                   Text(
                    'Skip the guess work. let us guide you to the best gym with everything you need.',
                    textAlign: TextAlign.center,
                     style: AppTypography.bodyMedium.copyWith(
                          color: ColorsAssets.   textLight, 
                        ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 32,
                        height: 4,
                        decoration: BoxDecoration(
                          color: ColorsAssets.primaryColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 16,
                        height: 4,
                        decoration: BoxDecoration(
                          color: ColorsAssets.textMedium,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                   const SizedBox(height: 30),
                  CustomMainButton(
                    text: 'Next',
                    onPressed: () {
                        context.pushNamed(RouteNames.onboarding2);
                    },
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                      onPressed: () {
                        // context.goNamed(RouteNames.home);
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: ColorsAssets.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
