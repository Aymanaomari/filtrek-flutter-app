import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordSection extends StatelessWidget {
  const ForgotPasswordSection({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          child: Text(
            "Forget Password ?",
            style: AppTypography.body2.copyWith(color: color.primary),
          ),
          onTap: () {
            //TODO : Add navigation to request reset password screen
            // context.pushNamed(RouteNames.enterEmailScreen);
          },
        ),
      ],
    );
  }
}
