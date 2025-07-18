import 'package:filtrek_app/features/authentication/presentation/providers/login_screen_manager_provider.dart';
import 'package:filtrek_app/presentation/widgets/app_widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginButton extends ConsumerWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme;
    final loginScreenManagerNotifier =
        ref.read(loginScreenManagerProvider.notifier);
    final loginScreenManagerState = ref.read(loginScreenManagerProvider);
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: AppButton(
        text: "Get Started",
        onPressed: () async {
          if (await loginScreenManagerNotifier.login()) {
            //TODO : Add navigation to home screen
            // context.replaceNamed(RouteNames.welcome);
          }
        },
        borderRadius: 100,
        child: loginScreenManagerState.isLoading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(color.surface),
              )
            : null,
      ),
    );
  }
}
