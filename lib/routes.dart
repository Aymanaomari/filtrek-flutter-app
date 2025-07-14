import 'package:filtrek_app/features/fltrik/presentation/screens/authentification/login_screen.dart';
import 'package:filtrek_app/features/fltrik/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:filtrek_app/features/fltrik/presentation/screens/test/test_screen.dart';
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
        name: RouteNames.onboarding,
        path: "/onBoarding",
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(
          name: RouteNames.login,
          path: "/login",
          builder: (context, state) => LoginScreen()),
      GoRoute(
          path: "/test",
          name: RouteNames.test,
          builder: (context, state) => TestScreen()),
    ],
    initialLocation: "/onBoarding");
