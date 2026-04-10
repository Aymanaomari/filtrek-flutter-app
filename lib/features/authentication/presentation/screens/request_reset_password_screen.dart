import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/features/authentication/presentation/providers/request_reset_password_screen_manager.dart';
import 'package:filtrek_app/features/authentication/presentation/screens/otp_verification_screen.dart';
import 'package:filtrek_app/features/shared/widgets/app_button.dart';
import 'package:filtrek_app/features/shared/widgets/app_phone_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RequestResetPasswordScreen extends ConsumerStatefulWidget {
  static const String routeName = '/request-reset-password';
  static const String routePath = '/request-reset-password';

  const RequestResetPasswordScreen({super.key});

  @override
  ConsumerState<RequestResetPasswordScreen> createState() =>
      _RequestResetPasswordScreenState();
}

class _RequestResetPasswordScreenState
    extends ConsumerState<RequestResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final requestResetState =
        ref.watch(requestResetPasswordScreenManagerProvider);
    final requestResetNotifier =
        ref.read(requestResetPasswordScreenManagerProvider.notifier);

    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.phone_outlined, color: colors.primary, size: 40),
                    const SizedBox(height: 20),
                    Text(
                      "Reset Password",
                      style:
                          AppTypography.h2.copyWith(color: colors.onSecondary),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Enter the email associated with your account and we’ll send an email to reset your password",
                      style:
                          AppTypography.body2.copyWith(color: colors.outline),
                    ),
                    const SizedBox(height: 30),
                    Form(
                      // key: state.formKey,
                      child: AppPhoneTextField(
                        onChanged: (value) {
                          requestResetNotifier.updatePhoneNumber(value);
                        },
                        icon: Icons.phone,
                        hintText: "Enter Your Phone Number",
                        errorText: requestResetState.errorMessage,
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    const SizedBox(
                      height: 80, // Extra space for button
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 24,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 48,
                width: double.infinity,
                child: AppButton(
                  onPressed: () async {
                    var response =
                        await requestResetNotifier.requestPasswordReset();
                    if (response) {
                      // Re-read the latest state to get updated userId
                      final latestState =
                          ref.read(requestResetPasswordScreenManagerProvider);
                      context.pushNamed(OtpVerificationScreen.routeName,
                          queryParameters: {
                            'purpose': 'reset-password',
                            'userId': latestState.userId,
                            'phone': latestState
                                .phoneController.value!.completeNumber
                          });
                    }
                  },
                  text: "Verify",
                  child: requestResetState.isLoading
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(colors.surface),
                        )
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
