import 'package:filtrek_app/core/exceptions/network_exception.dart';
import 'package:filtrek_app/domain/entities/user/current_user_response_entity.dart';
import 'package:filtrek_app/domain/usecases/user/update_current_user_usecase.dart';
import 'package:filtrek_app/domain/usecases/user/upload_profile_image_usecase.dart';
import 'package:filtrek_app/presentation/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:phone_text_field/model/phone_number.dart';
import 'edit_profile_screen_state.dart';
import 'package:filtrek_app/domain/entities/user/current_user_update_entity.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

final editProfileScreenProvider =
    StateNotifierProvider<EditProfileScreenNotifier, EditProfileScreenState>(
  (ref) {
    final currentUser = ref.watch(userStateProvider);
    return EditProfileScreenNotifier(
        currentUser.currentUser,
        ref.read(updateCurrentUserUsercaseProvider),
        ref.read(uploadProfileImageUsecaseProvider));
  },
);

class EditProfileScreenNotifier extends StateNotifier<EditProfileScreenState> {
  final UpdateCurrentUserUsecase _updateCurrentUserUsecase;
  final UploadProfileImageUsecase _uploadProfileImageUsecase;

  EditProfileScreenNotifier(
    CurrentUserResponseEntity? user,
    this._updateCurrentUserUsecase,
    this._uploadProfileImageUsecase,
  ) : super(
          EditProfileScreenState(
            currentUserResponseEntity: user,
            usernameController:
                TextEditingController(text: user?.username ?? ''),
            emailController: TextEditingController(text: user?.email ?? ''),
            phoneController: ValueNotifier<PhoneNumber?>(
              user != null
                  ? PhoneNumber(
                      countryCode: user.phoneCountryCode ?? '',
                      number: user.phoneNumber ?? '',
                      countryISOCode: '',
                    )
                  : null,
            ),
            currentUserUpdateEntity: null,
          ),
        );

  Future<void> updateCurrentUser() async {
    final original = state.currentUserResponseEntity;
    final updatedEntity = CurrentUserUpdateEntity(
      username:
          _getChangedValue(state.usernameController.text, original?.username),
      email: _getChangedValue(state.emailController.text, original?.email),
      phoneNumber: _getChangedValue(
          state.phoneController.value?.number, original?.phoneNumber),
      phoneCountryCode: _getChangedValue(
          state.phoneController.value?.countryCode, original?.phoneCountryCode),
    );
    if (_isEntityEmpty(updatedEntity)) return;
    state = state.copyWith(
        currentUserUpdateEntity: updatedEntity, isUpdateLoading: true);
    try {
      final updatedUser = await _updateCurrentUserUsecase.call(updatedEntity);
      state = state.copyWith(
        isUpdateLoading: false,
        currentUserResponseEntity: updatedUser,
        currentUserUpdateEntity: null,
        error: null,
      );
      debugPrint('Current user updated successfully');
    } on NetworkException {
      rethrow;
    } catch (e, trace) {
      state = state.copyWith(
          isUpdateLoading: false, error: 'Failed to update user: $e');
      debugPrint('Update user error: $e');
      debugPrintStack(stackTrace: trace);
    }
  }

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        state = state.copyWith(
            image: File(image.path),
            imageUploadingisLoading: true,
            imageUploadError: null);
        debugPrint('Image picked: ${image.path}');
        try {
          final updatedUser =
              await _uploadProfileImageUsecase.call(File(image.path));
          state = state.copyWith(
            imageUploadingisLoading: false,
            currentUserResponseEntity: updatedUser,
            imageUploadError: null,
          );
          debugPrint('Profile image uploaded successfully');
        } on HttpException catch (e) {
          state = state.copyWith(
              imageUploadingisLoading: false,
              imageUploadError: 'HTTP error: ${e.message}');
          debugPrint('Profile image upload HTTP error: ${e.message}');
        } on NetworkException {
          rethrow;
        } catch (e) {
          state = state.copyWith(
              imageUploadingisLoading: false,
              imageUploadError: 'Profile image upload error: $e');
          debugPrint('Profile image upload error: $e');
        }
      } else {
        debugPrint('No image picked');
      }
    } catch (e) {
      state = state.copyWith(
          imageUploadingisLoading: false,
          imageUploadError: 'Image picker error: $e');
      debugPrint('Image picker error: $e');
    }
  }

  String? _getChangedValue(String? newValue, String? originalValue) {
    if (newValue == null || newValue == originalValue) return null;
    return newValue;
  }

  bool _isEntityEmpty(CurrentUserUpdateEntity entity) {
    return entity.username == null &&
        entity.email == null &&
        entity.phoneNumber == null &&
        entity.phoneCountryCode == null;
  }
}
