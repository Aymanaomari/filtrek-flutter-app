import 'dart:async';
import 'package:filtrek_app/core/class/googleSignin.dart';
import 'package:filtrek_app/core/exceptions/http_exception.dart';
import 'package:filtrek_app/core/exceptions/network_exception.dart';
import 'package:filtrek_app/features/authentication/domain/entities/oauth_login_entity.dart';
import 'package:filtrek_app/features/authentication/domain/entities/signup_entity.dart';
import 'package:filtrek_app/features/authentication/domain/entities/signup_response_entity.dart';
import 'package:filtrek_app/features/authentication/domain/usecases/oauth_login_usecase.dart';
import 'package:filtrek_app/features/authentication/domain/usecases/signup_usecase.dart';
import 'package:filtrek_app/features/authentication/presentation/providers/auth_provider.dart';
import 'package:filtrek_app/features/authentication/presentation/providers/signup_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phone_text_field/phone_text_field.dart';

class SignupManagerNotifier extends StateNotifier<SignupScreenState> {
  final SignupUsecase _signupUsecase;
  final OauthLoginUsecase _oauthLoginUsecase;

  SignupManagerNotifier(this._signupUsecase, this._oauthLoginUsecase)
      : super(_initialState());

  static SignupScreenState _initialState() {
    return SignupScreenState(
      signupResponseEntity: SignupResponseEntity(id: "", phone: ""),
      formKey: GlobalKey<FormState>(),
      passwordController: TextEditingController(),
      usernameController: TextEditingController(),
      mobileController: TextEditingController(),
      phoneController: ValueNotifier<PhoneNumber?>(null),
      isLoading: false,
      errorMessage: null,
    );
  }

  @override
  void dispose() {
    state.passwordController.dispose();
    state.usernameController.dispose();
    state.mobileController.dispose();
    state.phoneController.dispose();
    super.dispose();
  }

  /// Performs the actual signup API call
  /// Returns the SignupResponseEntity on success, null on failure
  performSignup() async {
    try {
      state = state.copyWith(isLoading: true, phoneNumberError: null);

      if (state.formKey.currentState!.validate()) {
        state = state.copyWith(isLoading: false);
        return null;
      }

      final username = state.usernameController.text.trim();
      final password = state.passwordController.text.trim();
      final phoneNumber = state.phoneController.value;

      SignupEntity signupData = SignupEntity(
        username: username,
        password: password,
        phoneCountryCode: phoneNumber!.countryCode,
        phoneNumber: phoneNumber.number,
      );

      var response = await _signupUsecase.call(signupData);
      state = state.copyWith(signupResponseEntity: response);
      state = state.copyWith(isLoading: false);
      return true;
    } on HttpException catch (e) {
      if (e.statusCode == 400) {
        state = state.copyWith(
            isLoading: false, phoneNumberError: "Phone number already exists");
        return null;
      }

      return null;
    } catch (e) {
      state = state.copyWith(
          isLoading: false,
          errorMessage: 'An unexpected error occurred. Please try again.');
      debugPrint('Signup error: ${e.toString()}');
      return null;
    }
  }

  Future<bool> googleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSigninApi.login();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final oAuthEntity = OAuthLoginEntity(
          email: googleUser.email,
          oauthProvider: "GOOGLE",
          oauthId: googleUser.id,
          name: googleUser.displayName ?? '',
          profilePictureUrl: googleUser.photoUrl ?? "",
          accessToken: googleAuth.accessToken ?? '',
        );

        await _oauthLoginUsecase.call(oAuthEntity);
        // Use response if needed
        return true;
      }
    } on HttpException catch (e, stack) {
      print("Google Sign-In HTTP Error: ${e.message}");
      print(stack);
      return false;
    } on NetworkException {
      rethrow;
    } catch (error, stack) {
      print("Google Sign-In Error: $error");
      print(stack);
      return false;
    }
    return false;
  }
}

final signupManagerProvider =
    StateNotifierProvider.autoDispose<SignupManagerNotifier, SignupScreenState>(
        (ref) {
  final link = ref.keepAlive();
  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });
  ref.onDispose(() {
    timer.cancel();
  });

  SignupUsecase signupUsecase = ref.read<SignupUsecase>(signupUsecaseProvider);
  OauthLoginUsecase oauthLoginUsecase = ref.read(oAuthUseCaseProvider);
  return SignupManagerNotifier(signupUsecase, oauthLoginUsecase);
});
