import 'package:filtrek_app/features/fltrik/presentation/screens/otp_verification/otp_verification_screen.dart';
import 'package:filtrek_app/features/fltrik/presentation/screens/test/test_screen.dart';
import 'package:filtrek_app/features/fltrik/presentation/screens/verify_account/verify_account_screen.dart';
import 'package:filtrek_app/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter routes = GoRouter(
    redirect: (context, state) {},
    errorBuilder: (context, state) {
      return Scaffold(); //replaace with the global error handling page
    },
    routes: [
      GoRoute(
          name: RouteNames.home,
          path: "/",
          builder: (context, state) => Scaffold()),
      GoRoute(
          path: "/test",
          name: RouteNames.test,
          builder: (context, state) => TestScreen()),
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
