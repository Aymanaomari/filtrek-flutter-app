import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/presentation/providers/user_provider.dart';
import 'package:filtrek_app/presentation/widgets/home/profile_picture.dart';
import 'package:filtrek_app/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UserProfileTile extends ConsumerWidget {
  const UserProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userStateProvider);

    final color = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: color.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: ProfilePicture(),
        title: Text(userState.currentUser!.username,
            style: AppTypography.body1.copyWith(color: color.onSecondary)),
        subtitle: Text(
            "@${userState.currentUser!.username.replaceAll(" ", "")}",
            style: AppTypography.body2.copyWith(color: color.outline)),
        onTap: () => context.pushNamed(RouteNames.editProfile),
      ),
    );
  }
}
