import 'package:filtrek_app/features/fltrik/presentation/screens/reset_password/enter_new_password_screen.dart';
import 'package:filtrek_app/features/fltrik/presentation/screens/reset_password/password_changed_screen.dart';
import 'package:filtrek_app/features/fltrik/presentation/screens/test/test_screen.dart';
import 'package:filtrek_app/features/fltrik/presentation/screens/reset_password/enter_email_screen.dart';
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
          name: RouteNames.home,
          path: "/",
          builder: (context, state) => Scaffold()),
      GoRoute(
          path: "/test",
          name: RouteNames.test,
          builder: (context, state) => TestScreen()),
      GoRoute(
          path: "/email",
          name: RouteNames.enterEmailScreen,
          builder: (context, state) => EnterEmailScreen()),
      GoRoute(
          path: "/newPwd",
          name: RouteNames.enterNewPasswordScreen,
          builder: (context, state) => EnterNewPasswordScreen()),
    ],
    initialLocation: "/email");
