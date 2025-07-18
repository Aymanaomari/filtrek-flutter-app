import 'package:filtrek_app/features/fltrik/core/constant/colors_assets.dart';
import 'package:filtrek_app/features/fltrik/core/theme/app_typography.dart';
import 'package:filtrek_app/features/fltrik/presentation/widgets/app_widgets/app_button.dart';
import 'package:flutter/material.dart';

class VerifyAccountScreen extends StatefulWidget {
  const VerifyAccountScreen({super.key});

  @override
  State<VerifyAccountScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  String selectedVerificationMethod = 'email'; // Default selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Verify your identity",
              style: AppTypography.h2.copyWith(color: ColorsAssets.textLight),
            ),
            Text(
              "Choose a method to verify your identity",
              style: AppTypography.body1
                  .copyWith(color: ColorsAssets.textMediumDark),
            ),
            SizedBox(
              height: 32,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedVerificationMethod = 'email';
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: ColorsAssets.thirdColor),
                  borderRadius: BorderRadius.circular(12),
                  color: selectedVerificationMethod == 'email'
                      ? ColorsAssets.thirdColor
                      : null,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: selectedVerificationMethod == 'email'
                              ? ColorsAssets.primaryColor
                              : ColorsAssets.thirdColor,
                          borderRadius: BorderRadius.circular(99)),
                      child: Icon(
                        Icons.email_outlined,
                        color: selectedVerificationMethod == 'email'
                            ? ColorsAssets.secondaryColor
                            : ColorsAssets.primaryColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: AppTypography.subtitle1.copyWith(
                              color: ColorsAssets.textLight,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Verify with your Email",
                          style: AppTypography.body2
                              .copyWith(color: ColorsAssets.textMedium),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedVerificationMethod = 'phone';
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: ColorsAssets.thirdColor),
                  borderRadius: BorderRadius.circular(12),
                  color: selectedVerificationMethod == 'phone'
                      ? ColorsAssets.thirdColor
                      : null,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: selectedVerificationMethod == 'phone'
                              ? ColorsAssets.primaryColor
                              : ColorsAssets.thirdColor,
                          borderRadius: BorderRadius.circular(99)),
                      child: Icon(
                        Icons.phone_outlined,
                        color: selectedVerificationMethod == 'phone'
                            ? ColorsAssets.secondaryColor
                            : ColorsAssets.primaryColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Phone Number",
                          style: AppTypography.subtitle1.copyWith(
                              color: ColorsAssets.textLight,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Verify with your Phone Number",
                          style: AppTypography.body2
                              .copyWith(color: ColorsAssets.textMedium),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Spacer(),
            SizedBox(
                width: double.infinity,
                height: 48,
                child: AppButton(
                  text: "Verify",
                  backgroundColor: ColorsAssets.primaryColor,
                  onPressed: () {},
                )),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
