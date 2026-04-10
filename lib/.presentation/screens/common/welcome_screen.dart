import 'package:filtrek_app/core/constant/image_assets.dart';
import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/presentation/providers/user_provider.dart';
import 'package:filtrek_app/presentation/widgets/app_widgets/app_button.dart';
import 'package:filtrek_app/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAssets.welcomeBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildWelcomeText(color),
            const SizedBox(height: 24),
            _buildSubtitleText(color),
            const SizedBox(height: 32),
            _buildActionButton(color),
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeText(ColorScheme color) {
    return Text(
      "Your Fitness Hub Awaits",
      style: AppTypography.h1.copyWith(color: color.onSecondary),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitleText(ColorScheme color) {
    return Text(
      "Locate nearby gyms and book sessions with expert trainers",
      textAlign: TextAlign.center,
      style: AppTypography.body2.copyWith(color: color.outline),
    );
  }

  Widget _buildActionButton(ColorScheme color) {
    return Consumer(
      builder: (context, ref, child) {
        final userState = ref.watch(userStateProvider);
        final userNotifier = ref.read(userStateProvider.notifier);

        ref.listen<UserState>(userStateProvider, (previous, next) {
          _handleUserStateChange(context, previous, next);
        });

        return SizedBox(
          height: 48,
          width: double.infinity,
          child: AppButton(
            text: "Let's Move Now",
            onPressed: userNotifier.refreshCurrentUser,
            child: userState.isLoading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(color.surface),
                  )
                : null,
          ),
        );
      },
    );
  }

  void _handleUserStateChange(
    BuildContext context,
    UserState? previous,
    UserState next,
  ) {
    if (next.currentUser != null) {
      if (next.currentUser!.role == "Coach") {
        context.replaceNamed(RouteNames.coachHomeScreen);
      } else if (next.currentUserMembership == null &&
          next.isMembershipLoading) {
        // Wait for membership to load, do not navigate yet
        return;
      } else if (next.currentUserMembership != null) {
        context.replaceNamed(RouteNames.clientHomeScreen);
      } else {
        context.replaceNamed(RouteNames.homeScreen);
      }
    }
  }
}
