import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/presentation/providers/managers/edit_profile/edit_profile_screen_manager_provider.dart';
import 'package:filtrek_app/presentation/providers/user_provider.dart';
import 'package:filtrek_app/presentation/widgets/app_widgets/app_phone_text_field.dart';
import 'package:filtrek_app/presentation/widgets/app_widgets/app_text_field.dart';
import 'package:filtrek_app/presentation/widgets/home/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ColorScheme.of(context);
    final editProfileState = ref.watch(editProfileScreenProvider);
    final editProfileNotifier = ref.read(editProfileScreenProvider.notifier);
    final userNotifier = ref.read(userStateProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile",
            style: AppTypography.body1.copyWith(color: color.onSecondary)),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            GestureDetector(
              onTap: () async {
                await editProfileNotifier.pickImage();
                await userNotifier.refreshCurrentUser();
              },
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: editProfileState.imageUploadingisLoading
                        ? Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: color.secondary.withOpacity(0.2),
                            ),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : ProfilePicture(
                            width: 100,
                            height: 100,
                          ),
                  ),
                  Positioned(
                    right: MediaQuery.of(context).size.width / 2 -
                        50 -
                        16, // 60 is half of image width, 20 is offset
                    bottom: 0,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: color.secondary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.edit_outlined,
                          color: color.onSecondary, size: 18),
                    ),
                  ),
                ],
              ),
            ),
            if (editProfileState.imageUploadError != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  editProfileState.imageUploadError!,
                  style: TextStyle(color: color.error, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 40),
            AppTextField(
              labelText: "Username",
              icon: Icons.person_outline,
              controller: editProfileState.usernameController,
            ),
            const SizedBox(height: 16),
            AppTextField(
              labelText: "Email",
              icon: Icons.email_outlined,
              controller: editProfileState.emailController,
            ),
            const SizedBox(height: 16),
            AppPhoneTextField(
              hintText: "phone Number",
              icon: Icons.phone_outlined,
              controller: editProfileState.phoneController,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: MaterialButton(
                onPressed: () async {
                  await editProfileNotifier.updateCurrentUser();
                  await userNotifier.refreshCurrentUser();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
                color: color.primary,
                child: editProfileState.isUpdateLoading
                    ? CircularProgressIndicator()
                    : Text(
                        "Save Changed",
                        style:
                            AppTypography.button.copyWith(color: color.surface),
                      ),
              ),
            ),
            SizedBox(
              height: 24,
            )
          ],
        ),
      ),
    );
  }
}
