import 'package:filtrek_app/features/fltrik/core/constant/colors_assets.dart';
import 'package:filtrek_app/features/fltrik/core/constant/image_assets.dart';
import 'package:filtrek_app/features/fltrik/core/theme/app_typography.dart';
import 'package:filtrek_app/features/fltrik/presentation/widgets/app_widgets/app_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageAssets.welcomeBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Your Fitness Hub Awaits",
            style: AppTypography.h1.copyWith(color: ColorsAssets.textLight),
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            "Locate nearby gyms and book sessions with expert trainers",
            textAlign: TextAlign.center,
            style: AppTypography.body2.copyWith(color: ColorsAssets.textMedium),
          ),
          SizedBox(
            height: 32,
          ),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: AppButton(
              text: "Let's Move Now",
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 64,
          ),
        ],
      ),
    ));
  }
}
