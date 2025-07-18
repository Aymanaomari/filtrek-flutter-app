import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/presentation/providers/user_provider.dart';
import 'package:filtrek_app/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme;
    final userNotifier = ref.read(userStateProvider.notifier);
    final userState = ref.watch(userStateProvider);

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color.onSecondary,
        foregroundColor: color.onPrimary,
        minimumSize: const Size(double.infinity, 50),
      ),
      onPressed: userState.isLogoutLoading
          ? null
          : () async {
              await userNotifier.logout();
              context.goNamed(RouteNames.login);
            },
      icon: userState.isLogoutLoading
          ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(color.surface),
              ),
            )
          : Icon(
              Icons.logout_outlined,
              color: color.surface,
              size: 24,
            ),
      label: Text(
        userState.isLogoutLoading ? "Logging Out..." : "Log Out",
        style: AppTypography.buttonText.copyWith(color: color.surface),
      ),
    );
  }
}
