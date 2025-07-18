import 'package:filtrek_app/features/fltrik/presentation/widgets/app_widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:filtrek_app/features/fltrik/core/constant/colors_assets.dart';
import 'package:filtrek_app/features/fltrik/core/constant/image_assets.dart';
import 'package:filtrek_app/features/fltrik/presentation/widgets/onboarding/left_diagonal_image.dart';
import 'package:filtrek_app/features/fltrik/core/theme/app_typography.dart';

class OnBoardingScreen2 extends StatelessWidget {
  const OnBoardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorsAssets.scaffoldBackground,
      body: Column(
        children: [
          LeftDiagonalImage(
            imagePath: ImageAssets.onBoarding2, // exemple
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
                    'Meet Expert Coaches',
                    textAlign: TextAlign.center,
                    style: AppTypography.h1.copyWith(
                      color: ColorsAssets.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Unlock your potential with guidance from top fitness professionals-right you train.',
                    textAlign: TextAlign.center,
                    style: AppTypography.body2.copyWith(
                      color: ColorsAssets.textLight,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 16,
                        height: 4,
                        decoration: BoxDecoration(
                          color: ColorsAssets.textMedium,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 32,
                        height: 4,
                        decoration: BoxDecoration(
                          color: ColorsAssets.primaryColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: AppButton(
                      text: "Start Now",
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
