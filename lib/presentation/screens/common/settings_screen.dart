import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/presentation/widgets/settings/logout_button.dart';
import 'package:filtrek_app/presentation/widgets/settings/user_profile_tile.dart';
import 'package:filtrek_app/presentation/widgets/settings/settings_group_container.dart';
import 'package:filtrek_app/presentation/widgets/settings/settings_list_tile.dart';
import 'package:filtrek_app/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:filtrek_app/presentation/providers/notification_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: color.background,
      appBar: AppBar(
        title: const Text('Settings', style: AppTypography.subtitle1),
        centerTitle: true,
        backgroundColor: color.background,
        foregroundColor: color.onBackground,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const UserProfileTile(),
            const SizedBox(height: 16),
            // Notification & Settings group
            SettingsGroupContainer(children: [
              SettingsListTile(
                onTap: () {
                  context.pushNamed(RouteNames.editProfile);
                },
                icon: Icons.person_outline,
                iconColor: color.primary,
                title: "Edit Profile",
                subtitle: "Change profile picture, number, E-mail",
                trailing: Icon(Icons.arrow_forward_ios_outlined,
                    size: 12, color: color.tertiary),
              ),
              SettingsListTile(
                onTap: () {
                  context.pushNamed(RouteNames.changePasswordScreen);
                },
                icon: Icons.lock_outline,
                iconColor: color.primary,
                title: "Change Password",
                subtitle: "Update and strenghten account security",
                trailing: Icon(Icons.arrow_forward_ios,
                    size: 12, color: color.tertiary),
              ),
              SettingsListTile(
                icon: Icons.security_outlined,
                iconColor: color.primary,
                title: "Terms of Use ",
                subtitle: "Protect your account now",
                trailing: Icon(Icons.arrow_forward_ios,
                    size: 12, color: color.tertiary),
              ),
              // SettingsListTile(
              //   icon: Icons.payment_outlined,
              //   iconColor: color.primary,
              //   title: "Add Card ",
              //   subtitle: "Securely add payment method",
              //   trailing: Icon(Icons.arrow_forward_ios,
              //       size: 12, color: color.tertiary),
              // ),
            ]),
            const SizedBox(height: 16),
            // Language & Payment Method group
            SettingsGroupContainer(children: [
              SettingsListTile(
                icon: Icons.notifications_on_outlined,
                iconColor: color.primary,
                title: "Notifications ",
                subtitle: "Customize your Notifications Preferences",
                trailing: Consumer(
                  builder: (context, ref, _) {
                    final notificationEnabled = ref.watch(notificationProvider
                        .select((s) => s.notificationEnabled));
                    final notifier = ref.read(notificationProvider.notifier);
                    return Switch(
                      value: notificationEnabled,
                      onChanged: (value) async {
                        if (value) {
                          await notifier.enableNotifications();
                        } else {
                          await notifier.disableNotifications();
                        }
                      },
                    );
                  },
                ),
              ),
              SettingsListTile(
                icon: Icons.info_outline,
                iconColor: color.primary,
                title: "FAQ",
                subtitle:
                    "Find answers to common questions and get help with your account",
                trailing: Icon(Icons.arrow_forward_ios,
                    size: 12, color: color.tertiary),
              ),
            ]),
            const SizedBox(height: 16),
            // FAQ & Terms of Service group

            Spacer(),
            LogoutButton(),
            SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
