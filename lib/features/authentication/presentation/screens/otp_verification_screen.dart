import 'dart:async';
import 'package:filtrek_app/core/constant/image_assets.dart';
import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/core/utils/extensions.dart';
import 'package:filtrek_app/features/authentication/presentation/providers/otp_verification_provider.dart';
import 'package:filtrek_app/features/authentication/presentation/screens/enter_new_password_screen.dart';
import 'package:filtrek_app/features/authentication/presentation/widgets/pinput_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  static const String routeName = '/otp-verification';
  static const String routePath = '/otp-verification';

  final String phone;
  final String userId;
  final String? purpose;

  const OtpVerificationScreen({
    super.key,
    required this.phone,
    required this.userId,
    this.purpose,
  });

  @override
  ConsumerState<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  final FocusNode _pinFocusNode = FocusNode();
  bool _isPinFocused = false;
  int _resendCounter = 0;
  Timer? _resendTimer;

  @override
  void initState() {
    super.initState();
    _pinFocusNode.addListener(() {
      setState(() {
        _isPinFocused = _pinFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _pinFocusNode.dispose();
    _resendTimer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    setState(() {
      _resendCounter = 600; // 10 minutes in seconds
    });
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCounter > 0) {
        setState(() {
          _resendCounter--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final otpState = ref.watch(otpVerificationProvider);
    final otpNotifier = ref.read(otpVerificationProvider.notifier);

    // Start timer if resendError is set and timer not running
    if (otpState.resendError != null && _resendCounter == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _startResendTimer();
      });
    }

    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.translucent,
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  child: Image.asset(
                    ImageAssets.otpBackground,
                    width: _isPinFocused
                        ? 40.0.wp(context).clamp(160, 180)
                        : 60.0.wp(context).clamp(300, 320),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Verification",
                            style: AppTypography.h1.copyWith(
                              color: color.onSecondary,
                            )),
                        Row(
                          spacing: 8,
                          children: [
                            Text(
                              "Enter the OTP sent to",
                              style: AppTypography.body1
                                  .copyWith(color: color.outlineVariant),
                            ),
                            Text(
                              widget.phone,
                              style: AppTypography.body1.copyWith(
                                  color: color.primary,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ]),
                ),
                const SizedBox(
                  height: 32,
                ),
                PinputWidget(
                  focusNode: _pinFocusNode,
                  onCompleted: (pin) async {
                    bool success;
                    if (widget.purpose == "reset-password") {
                      success = await otpNotifier.verifyResetPasswordOtp(
                        userId: widget.userId,
                        phone: widget.phone,
                        pin: pin,
                      );
                      if (success && context.mounted) {
                        context.replaceNamed(EnterNewPasswordScreen.routeName);
                      }
                    } else {
                      success = await otpNotifier.verifyAccount(
                        userId: widget.userId,
                        phone: widget.phone,
                        pin: pin,
                      );
                      if (success && context.mounted) {
                        // context.replaceNamed(RouteNames.genderChooseScreen);
                      }
                    }
                  },
                  isError: otpState.error != null && otpState.error!.isNotEmpty,
                ),
                const SizedBox(height: 36),
                if (otpState.resendError != null)
                  Column(
                    children: [
                      Text(
                        "Please wait before resending OTP.",
                        style: AppTypography.body1.copyWith(color: color.error),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Try again in ${(_resendCounter ~/ 60).toString().padLeft(2, '0')}:${(_resendCounter % 60).toString().padLeft(2, '0')} min",
                        style:
                            AppTypography.body2.copyWith(color: color.primary),
                      ),
                    ],
                  )
                else
                  Row(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't receive the OTP ?",
                        style: AppTypography.body1
                            .copyWith(color: color.outlineVariant),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (widget.purpose == "reset-password") {
                          } else {
                            await otpNotifier
                                .resentOtpVerification(widget.userId);
                          }
                        },
                        child: Text(
                          "Resend",
                          style: AppTypography.body1.copyWith(
                              color: color.primary,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      if (otpState.isLoading)
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(color.primary),
                            ),
                          ),
                        ),
                    ],
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
