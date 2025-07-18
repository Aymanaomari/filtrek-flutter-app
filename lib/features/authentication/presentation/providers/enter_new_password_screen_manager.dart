import 'package:filtrek_app/core/exceptions/http_exception.dart';
import 'package:filtrek_app/core/exceptions/network_exception.dart';
import 'package:filtrek_app/features/authentication/domain/usecases/change_password_usecase.dart';
import 'package:filtrek_app/features/authentication/presentation/providers/auth_provider.dart';
import 'package:filtrek_app/features/authentication/presentation/providers/enter_new_password_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class EnterNewPasswordScreenNotifier
    extends StateNotifier<EnterNewPasswordScreenState> {
  final ChangePasswordUsecase _changePasswordUsecase;

  EnterNewPasswordScreenNotifier(this._changePasswordUsecase)
      : super(EnterNewPasswordScreenState(
          passwordTextController: TextEditingController(),
          passwordConfirmController: TextEditingController(),
          formKey: GlobalKey<FormState>(),
        ));

  // Add any business logic methods here

  Future<bool> changePassowrd() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      if (!state.formKey.currentState!.validate()) return false;
      final password = state.passwordTextController.text.trim();
      final confirmPassword = state.passwordConfirmController.text.trim();
      if (password != confirmPassword) {
        state =
            state.copyWith(isLoading: false, error: "Passwords do not match");
        return false;
      }
      await _changePasswordUsecase.call(password);
      state = state.copyWith(isLoading: false, error: null);
      return true;
    } on HttpException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      return false;
    } on NetworkException {
      rethrow;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }
}

final enterNewPasswordScreenProvider = StateNotifierProvider.autoDispose<
        EnterNewPasswordScreenNotifier, EnterNewPasswordScreenState>(
    (ref) => EnterNewPasswordScreenNotifier(
        ref.read(changePasswordUsecaseProvider)));
