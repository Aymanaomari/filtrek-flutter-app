import 'dart:ui';
import 'package:filtrek_app/features/fltrik/core/constant/colors_assets.dart';
import 'package:filtrek_app/features/fltrik/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BlurredDialogOverlay extends StatelessWidget {
  const BlurredDialogOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            color: Colors.black.withOpacity(0.3),
          ),
        ),
        Center(
            child: Material(
          borderRadius: BorderRadius.circular(16),
          color: ColorsAssets.primaryColor,
          child: Container(
            padding: EdgeInsets.all(24),
            width: MediaQuery.of(context).size.width * 0.9,
            height: 400,
            child: Column(
              children: [
                SizedBox(height: 20),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0x3314151A),
                      ),
                    ),
                    Icon(Icons.check_circle, size: 85, color: Colors.black),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "Password Changed Successfully",
                  style: AppTypography.h2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  "Your password has been updated. You can now log in with your new credentials.",
                  style: AppTypography.body1,
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsAssets.scaffoldBackground,
                    foregroundColor: ColorsAssets.primaryColor,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    context.go("/login"); // or Navigator.pop(context) + push
                  },
                  child: Text("Log In", style: AppTypography.buttonText),
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }
}
