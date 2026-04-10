import 'package:filtrek_app/features/authentication/presentation/providers/signup_screen_manager_provider.dart';
import 'package:filtrek_app/features/authentication/presentation/screens/otp_verification_screen.dart';
import 'package:filtrek_app/features/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignupButton extends ConsumerWidget {
  final ColorScheme color;

  const SignupButton({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupState = ref.watch(signupManagerProvider);
    final signupNotifier = ref.read(signupManagerProvider.notifier);

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: AppButton(
        onPressed: () async {
          final result = await signupNotifier.performSignup();
          if (result != null) {
            context.pushNamed(
              OtpVerificationScreen.routeName,
              queryParameters: {'phone': result.phone, 'userId': result.id},
            );
          }
        },
        borderRadius: 100,
        text: "Sign up",
        child: signupState.isLoading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(color.surface),
              )
            : null,
      ),
    );
  }
}
