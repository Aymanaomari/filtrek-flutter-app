import 'dart:io';

import 'package:filtrek_app/domain/entities/user/current_user_response_entity.dart';
import 'package:filtrek_app/domain/entities/user/current_user_update_entity.dart';
import 'package:flutter/material.dart';
import 'package:phone_text_field/model/phone_number.dart';

class EditProfileScreenState {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final ValueNotifier<PhoneNumber?> phoneController;
  final CurrentUserResponseEntity? currentUserResponseEntity;
  final String? error;
  final bool isUpdateLoading;
  final CurrentUserUpdateEntity? currentUserUpdateEntity;
  final File? image;
  final bool imageUploadingisLoading;
  final String? imageUploadError;

  EditProfileScreenState({
    this.currentUserResponseEntity,
    required this.usernameController,
    required this.emailController,
    required this.phoneController,
    this.error,
    this.isUpdateLoading = false,
    this.currentUserUpdateEntity,
    this.image,
    this.imageUploadingisLoading = false,
    this.imageUploadError,
  });

  EditProfileScreenState copyWith({
    TextEditingController? usernameController,
    TextEditingController? emailController,
    ValueNotifier<PhoneNumber?>? phoneController,
    CurrentUserResponseEntity? currentUserResponseEntity,
    String? error,
    bool? isUpdateLoading,
    CurrentUserUpdateEntity? currentUserUpdateEntity,
    File? image,
    bool? imageUploadingisLoading,
    String? imageUploadError,
  }) {
    return EditProfileScreenState(
      currentUserResponseEntity:
          currentUserResponseEntity ?? this.currentUserResponseEntity,
      usernameController: usernameController ?? this.usernameController,
      emailController: emailController ?? this.emailController,
      phoneController: phoneController ?? this.phoneController,
      error: error ?? this.error,
      isUpdateLoading: isUpdateLoading ?? this.isUpdateLoading,
      currentUserUpdateEntity:
          currentUserUpdateEntity ?? this.currentUserUpdateEntity,
      image: image ?? this.image,
      imageUploadingisLoading:
          imageUploadingisLoading ?? this.imageUploadingisLoading,
      imageUploadError: imageUploadError ?? this.imageUploadError,
    );
  }
}
