import 'package:filtrek_app/features/fltrik/presentation/screens/test/test_screen.dart';
import 'package:filtrek_app/features/fltrik/presentation/screens/onboarding/onboarding1_screen.dart';
import 'package:filtrek_app/features/fltrik/presentation/screens/onboarding/onboarding2_screen.dart';
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
          name: RouteNames.onboarding1,
          path: "/",
          builder: (context, state) => const OnBoardingScreen1()),
      GoRoute(
          name: RouteNames.onboarding2,
          path: "/onboarding2",
          builder: (context, state) => const OnBoardingScreen2(),
        ),
      GoRoute(
          path: "/test",
          name: RouteNames.test,
          builder: (context, state) => TestScreen()),
    ],
    initialLocation: "/");
