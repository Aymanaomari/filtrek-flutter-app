import 'package:filtrek_app/features/authentication/presentation/screens/enter_new_password_screen.dart';
import 'package:filtrek_app/features/authentication/presentation/screens/singin_screen.dart';
import 'package:filtrek_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:filtrek_app/features/authentication/presentation/screens/otp_verification_screen.dart';
import 'package:filtrek_app/features/authentication/presentation/screens/request_reset_password_screen.dart';
import 'package:filtrek_app/features/authentication/presentation/screens/signup_screen.dart';
import 'package:filtrek_app/features/onboarding/presentation/screens/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

final routeConfig = GoRouter(routes: [
  // --- Authentication Routes ---
  GoRoute(path: "/", builder: (context, state) => SplashScreen()),

  GoRoute(
      path: SigninScreen.routePath,
      name: SigninScreen.routeName,
      builder: (context, state) => SigninScreen()),
  GoRoute(
      path: SignupScreen.routePath,
      name: SignupScreen.routeName,
      builder: (context, state) => SignupScreen()),
  GoRoute(
      path: RequestResetPasswordScreen.routePath,
      name: RequestResetPasswordScreen.routeName,
      builder: (context, state) => RequestResetPasswordScreen()),
  GoRoute(
      path: EnterNewPasswordScreen.routePath,
      name: EnterNewPasswordScreen.routeName,
      builder: (context, state) => EnterNewPasswordScreen()),
  GoRoute(
    path: OtpVerificationScreen.routePath,
    name: OtpVerificationScreen.routeName,
    builder: (context, state) {
      final phone = state.uri.queryParameters['phone'] ?? '';
      final userId = state.uri.queryParameters['userId'] ?? '';
      final purpose = state.uri.queryParameters['purpose'] ?? '';
      return OtpVerificationScreen(
        phone: phone,
        userId: userId,
        purpose: purpose,
      );
    },
  ),

  // --- Onboarding Routes ---
  GoRoute(
      name: OnBoardingScreen.routeName,
      path: OnBoardingScreen.routePath,
      builder: (context, state) => const OnBoardingScreen()),

  // // --- User Shell Routes ---
  // StatefulShellRoute.indexedStack(
  //     redirect: (context, state) {
  //       final user = container.read(userStateProvider);
  //       if (user.currentUserMembership != null) {
  //         return "/client/home";
  //       }
  //     },
  //     builder: (context, state, navigationShell) =>
  //         AppUserLayoutScaffold(navigationShell: navigationShell),
  //     branches: [
  //       StatefulShellBranch(routes: [
  //         GoRoute(
  //           path: "/user/home",
  //           name: RouteNames.homeScreen,
  //           builder: (context, state) => HomeScreen(),
  //         ),
  //       ]),
  //       StatefulShellBranch(routes: [
  //         GoRoute(
  //           path: "/user/notifications",
  //           name: RouteNames.notificationScreen,
  //           builder: (context, state) => NotificationsScreen(),
  //         ),
  //       ]),
  //       StatefulShellBranch(routes: [
  //         GoRoute(
  //           path: "/user/Profile",
  //           name: RouteNames.profile,
  //           builder: (context, state) => ProfileScreen(),
  //         ),
  //       ])
  //     ]),

  // // --- Client Shell Routes ---
  // StatefulShellRoute.indexedStack(
  //     builder: (context, state, navigationShell) =>
  //         AppClientLayoutScaffold(navigationShell: navigationShell),
  //     branches: [
  //       StatefulShellBranch(routes: [
  //         GoRoute(
  //           path: "/client/home",
  //           name: RouteNames.clientHomeScreen,
  //           builder: (context, state) => ClientHomeScreen(),
  //         ),
  //       ]),
  //       StatefulShellBranch(routes: [
  //         GoRoute(
  //           path: "/client/plan",
  //           name: RouteNames.clientPlanScreen,
  //           builder: (context, state) => ClientPlanScreen(),
  //         ),
  //       ]),
  //       StatefulShellBranch(routes: [
  //         GoRoute(
  //           path: "/client/notifications",
  //           name: RouteNames.clientNotification,
  //           builder: (context, state) => NotificationsScreen(),
  //         ),
  //       ]),
  //       StatefulShellBranch(routes: [
  //         GoRoute(
  //           path: "/client/profile",
  //           name: RouteNames.clientProfileScreen,
  //           builder: (context, state) => ProfileScreen(),
  //         ),
  //       ])
  //     ]),

  // // --- Coach Shell Routes ---
  // StatefulShellRoute.indexedStack(
  //     builder: (context, state, navigationShell) =>
  //         AppCoachLayoutScaffold(navigationShell: navigationShell),
  //     branches: [
  //       StatefulShellBranch(routes: [
  //         GoRoute(
  //           path: "/coach/home",
  //           name: RouteNames.coachHomeScreen,
  //           builder: (context, state) => CoachHomeScreen(),
  //         ),
  //       ]),
  //       StatefulShellBranch(routes: [
  //         GoRoute(
  //           path: "/coach/planning",
  //           name: RouteNames.coachPlanningScreen,
  //           builder: (context, state) => CoachPlanningScreen(),
  //         ),
  //       ]),
  //       StatefulShellBranch(routes: [
  //         GoRoute(
  //           path: "/coach/profile",
  //           name: RouteNames.coachProfileScreen,
  //           builder: (context, state) => CoachProfileScreen(),
  //         ),
  //       ])
  //     ])
], initialLocation: "/");

final routeConfigProvider = Provider<GoRouter>((ref) {
  return routeConfig;
});
