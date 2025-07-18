import 'package:filtrek_app/features/fltrik/presentation/screens/authentification/login_screen.dart';
import 'package:filtrek_app/features/fltrik/presentation/screens/authentification/signup_screen.dart';
import 'package:filtrek_app/features/fltrik/presentation/screens/reset_password/enter_new_password_screen.dart';
import 'package:filtrek_app/features/fltrik/presentation/screens/otp_verification/otp_verification_screen.dart';
import 'package:filtrek_app/features/fltrik/presentation/screens/test/test_screen.dart';
import 'package:filtrek_app/features/fltrik/presentation/screens/onboarding/onboarding1_screen.dart';
import 'package:filtrek_app/features/fltrik/presentation/screens/onboarding/onboarding2_screen.dart';
import 'package:filtrek_app/features/fltrik/presentation/screens/welcome/welcome_screen.dart';
import 'package:filtrek_app/features/fltrik/presentation/screens/reset_password/enter_email_screen.dart';
import 'package:filtrek_app/features/fltrik/presentation/screens/verify_account/verify_account_screen.dart';
import 'package:filtrek_app/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter routes = GoRouter(
    redirect: (context, state) {
      return null;
    },
    errorBuilder: (context, state) {
      return Scaffold(); //replaace with the global error handling page
    },
    routes: [
      GoRoute(
          name: RouteNames.onboarding1,
          path: "/",
          builder: (context, state) => const OnBoardingScreen1()),
      GoRoute(
          name: RouteNames.onboarding2,
          path: "/onboarding2",
          builder: (context, state) => const OnBoardingScreen2()),
      GoRoute(
          path: "/test",
          name: RouteNames.test,
          builder: (context, state) => TestScreen()),
      GoRoute(
          path: "/login",
          name: RouteNames.login,
          builder: (context, state) => LoginScreen()),
      GoRoute(
          path: "/signup",
          name: RouteNames.signup,
          builder: (context, state) => SignupScreen()),
      GoRoute(
          path: "/welcome",
          name: RouteNames.welcome,
          builder: (context, state) => WelcomeScreen()),
      GoRoute(
          path: "/email",
          name: RouteNames.enterEmailScreen,
          builder: (context, state) => EnterEmailScreen()),
      GoRoute(
          path: "/newPwd",
          name: RouteNames.enterNewPasswordScreen,
          builder: (context, state) => EnterNewPasswordScreen()),
      GoRoute(
        path: "/otp-verification",
        name: RouteNames.otpVerification,
        builder: (context, state) => OtpVerificationScreen(),
      ),
      GoRoute(
        path: "/verify-account",
        name: RouteNames.verifyAccountScreen,
        builder: (context, state) => VerifyAccountScreen(),
      )
    ],
    initialLocation: "/verify-account");
