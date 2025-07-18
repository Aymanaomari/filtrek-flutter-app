import 'package:filtrek_app/features/fltrik/core/constant/colors_assets.dart';
import 'package:filtrek_app/features/fltrik/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinputWidget extends StatelessWidget {
  const PinputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 90,
      height: 70,
      textStyle: AppTypography.bodyLarge.copyWith(
          color: ColorsAssets.primaryColor, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsAssets.textMediumDark),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: ColorsAssets.primaryColor, width: 2),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
        // decoration: defaultPinTheme.decoration?.copyWith(
        //   color: Color.fromRGBO(234, 239, 243, 1),
        // ),
        decoration: defaultPinTheme.decoration?.copyWith(
      border: Border.all(color: ColorsAssets.primaryColor, width: 2),
    ));

    return Pinput(
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      // validator: (s) {
      //   return s == '2222' ? null : 'Pin is incorrect';
      // },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: (pin) => print(pin),
    );
  }
}
