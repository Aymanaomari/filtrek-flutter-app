import 'package:filtrek_app/features/fltrik/presentation/screens/test/test_screen.dart';
import 'package:filtrek_app/features/fltrik/presentation/screens/welcome/welcome_screen.dart';
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
          path: "/welcome",
          name: RouteNames.welcome,
          builder: (context, state) => WelcomeScreen()),
    ],
    initialLocation: "/welcome");
