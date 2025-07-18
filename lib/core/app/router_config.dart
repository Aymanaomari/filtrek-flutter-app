import 'package:filtrek_app/presentation/screens/common/test_screen.dart';
import 'package:filtrek_app/features/authentication/presentation/screens/enter_new_password_screen.dart';
import 'package:filtrek_app/features/authentication/presentation/screens/singin_screen.dart';
import 'package:filtrek_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:filtrek_app/features/authentication/presentation/screens/otp_verification_screen.dart';
import 'package:filtrek_app/features/authentication/presentation/screens/request_reset_password_screen.dart';
import 'package:filtrek_app/features/authentication/presentation/screens/signup_screen.dart';
import 'package:filtrek_app/features/onboarding/presentation/screens/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import 'package:filtrek_app/presentation/screens/common/no_connection_screen.dart';

final routeConfig = GoRouter(
    errorBuilder: (context, state) {
      return NoConnectionScreen(
        onRetry: () {
          // Retry logic can be implemented here
        },
      );
    },
    routes: [
      // --- Authentication Routes ---
      GoRoute(path: "/", builder: (context, state) => SplashScreen()),

      GoRoute(path: '/test', builder: (context, state) => TestScreen()),
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

      // // --- User Routes ---
      // GoRoute(
      //   path: "/gendre-choose",
      //   name: RouteNames.genderChooseScreen,
      //   builder: (context, state) => GendreChooseScreen(),
      // ),
      // GoRoute(
      //   path: "/age-choose",
      //   name: RouteNames.ageChooseScreen,
      //   builder: (context, state) => AgechooseScreen(),
      // ),
      // GoRoute(
      //   path: "/weigh-choose",
      //   name: RouteNames.weightChooseScreen,
      //   builder: (context, state) => WeightChooseScreen(),
      // ),
      // GoRoute(
      //   path: "/welcome",
      //   name: RouteNames.welcome,
      //   builder: (context, state) => WelcomeScreen(),
      // ),
      // GoRoute(
      //     path: "/single-gym",
      //     name: RouteNames.singleGymScreen,
      //     builder: (context, state) {
      //       final gymId = state.uri.queryParameters['gymId'] ?? "";
      //       return SingleGymScreen(gymId: gymId);
      //     }),
      // GoRoute(
      //     path: "/edit-profile",
      //     name: RouteNames.editProfile,
      //     builder: (context, state) {
      //       return EditProfileScreen();
      //     }),

      // GoRoute(
      //     path: "/gym-map",
      //     name: RouteNames.gymMap,
      //     builder: (context, state) {
      //       final lat =
      //           double.tryParse(state.uri.queryParameters['lat'] ?? "0.0") ??
      //               0.0;
      //       final long =
      //           double.tryParse(state.uri.queryParameters['long'] ?? "0.0") ??
      //               0.0;
      //       return GymMapScreen(destinationLat: lat, destinationLng: long);
      //     }),

      // // --- Common Routes ---
      // GoRoute(
      //     path: "/search",
      //     name: RouteNames.searchScreen,
      //     builder: (context, state) => SearchScreen()),
      // GoRoute(
      //     path: "/settings",
      //     name: RouteNames.settings,
      //     builder: (context, state) => SettingsScreen()),
      // GoRoute(
      //     path: "/client/choose-coach-appointment-screen",
      //     name: RouteNames.chooseCoachAppointment,
      //     builder: (context, state) => ChooseCoachAppointmentScreen()),
      // GoRoute(
      //     path: "/client/choose-time-appointment-screen",
      //     name: RouteNames.chooseTimeAppoiment,
      //     builder: (context, state) {
      //       final coachId = state.uri.queryParameters['coachId'] ?? '';

      //       return ChooseTimeAppointmentScreen(
      //         coachId: coachId,
      //       );
      //     }),
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
    ],
    initialLocation: "/");

final routeConfigProvider = Provider<GoRouter>((ref) {
  return routeConfig;
});
