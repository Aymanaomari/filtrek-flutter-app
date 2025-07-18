import 'package:filtrek_app/features/fltrik/core/constant/colors_assets.dart';
import 'package:filtrek_app/features/fltrik/core/constant/image_assets.dart';
import 'package:filtrek_app/features/fltrik/core/theme/app_typography.dart';
import 'package:filtrek_app/features/fltrik/core/utils/extensions.dart';
import 'package:filtrek_app/features/fltrik/presentation/widgets/app_widgets/app_button.dart';
import 'package:filtrek_app/features/fltrik/presentation/widgets/otp-verification/pinput_widget.dart';
import 'package:flutter/material.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Image.asset(
                ImageAssets.otpBackground,
                width: 70.0.wp(context).clamp(240, 280),
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Verification",
                          style: AppTypography.h2.copyWith(
                            color: ColorsAssets.textLight,
                          )),
                      Row(
                        spacing: 8,
                        children: [
                          Text(
                            "Enter the OTP sent to",
                            style: AppTypography.body1
                                .copyWith(color: ColorsAssets.textMediumDark),
                          ),
                          Text(
                            "lorem@example.com",
                            style: AppTypography.body1.copyWith(
                                color: ColorsAssets.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ]),
              ),
              SizedBox(
                height: 32,
              ),
              PinputWidget(),
              SizedBox(
                height: 48,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: AppButton(
                    text: "Verify",
                    borderRadius: 99,
                    onPressed: () {},
                  ),
                ),
              ),
              SizedBox(
                height: 48,
              ),
              Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the OTP?",
                    style: AppTypography.body1
                        .copyWith(color: ColorsAssets.textMediumDark),
                  ),
                  Text(
                    "Resend",
                    style: AppTypography.body1.copyWith(
                        color: ColorsAssets.primaryColor,
                        fontWeight: FontWeight.w600),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
