import 'package:filtrek_app/features/authentication/presentation/providers/login_screen_manager_provider.dart';
import 'package:filtrek_app/features/authentication/presentation/widgets/o2auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GoogleLoginSection extends ConsumerWidget {
  const GoogleLoginSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginScreenManagerNotifier =
        ref.read(loginScreenManagerProvider.notifier);

    return SizedBox(
      width: double.infinity,
      height: 54,
      child: GoogleO2authButton(
        borderRadius: 99,
        onPressed: () async {
          bool response = await loginScreenManagerNotifier.googleLogin();
          if (response) {
            //TODO : Add navigation to home screen
            // context.pushReplacementNamed(RouteNames.welcome);
          }
        },
      ),
    );
  }
}
