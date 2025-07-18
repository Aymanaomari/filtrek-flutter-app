import 'dart:async';
import 'package:filtrek_app/core/class/googleSignin.dart';
import 'package:filtrek_app/core/exceptions/http_exception.dart';
import 'package:filtrek_app/core/exceptions/network_exception.dart';
import 'package:filtrek_app/features/authentication/domain/entities/oauth_login_entity.dart';
import 'package:filtrek_app/features/authentication/domain/usecases/login_usecase.dart';
import 'package:filtrek_app/features/authentication/domain/usecases/oauth_login_usecase.dart';
import 'package:filtrek_app/features/authentication/presentation/providers/auth_provider.dart';
import 'package:filtrek_app/features/authentication/presentation/providers/login_screen_state.dart';
import 'package:filtrek_app/features/authentication/presentation/screens/signup_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phone_text_field/phone_text_field.dart';

class LoginScreenManagerNotifier extends StateNotifier<LoginScreenState> {
  final LoginUsecase _loginUsecase;
  final OauthLoginUsecase _oauthLoginUsecase;

  LoginScreenManagerNotifier(
    this._loginUsecase,
    this._oauthLoginUsecase,
  ) : super(LoginScreenState(
          formKey: GlobalKey<FormState>(),
          phoneController: ValueNotifier<PhoneNumber?>(null),
          passwordController: TextEditingController(),
          isLoading: false,
        ));

  @override
  void dispose() {
    state.passwordController.dispose();
    state.phoneController.dispose();
    super.dispose();
  }

  Future<bool> login() async {
    state = state.copyWith(emailError: false, passwordError: false);
    if (state.formKey.currentState?.validate() ?? false) {
      state = state.copyWith(isLoading: true);
      try {
        print('Attempting login with:');
        print('Country Code: ${state.phoneController.value?.countryCode}');
        print('Phone Number: ${state.phoneController.value?.number}');
        print('Password: ${state.passwordController.value.text}');
        await _loginUsecase.call(
            state.phoneController.value!.countryCode,
            state.phoneController.value!.number,
            state.passwordController.value.text);
        return true;
      } on HttpException catch (e) {
        print('HttpException: ${e.message}');
        state = state.copyWith(errorMessage: e.message);
        switch (e.statusCode) {
          case 404:
            state = state.copyWith(emailError: true);
            break;
          case 403:
            state = state.copyWith(passwordError: true);
            break;
        }
        return false;
      } on NetworkException {
        print('NetworkException occurred');
        rethrow;
      } catch (error) {
        print('Unknown error: $error');
        state = state.copyWith(errorMessage: error.toString());
        return false;
      } finally {
        state = state.copyWith(isLoading: false);
      }
    } else {
      state = state.copyWith(errorMessage: "Invalid form input");
      return false;
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
    } catch (error) {
      print("Google Sign-In Error: $error");
      return false;
    }
    return false;
  }

  void logout() {
    state = state.copyWith(isLoggedIn: false);
  }

  void refresh() {
    state = state.copyWith(isLoading: false, errorMessage: null);
  }

  void navigateToSignupScreen(context) {
    GoRouter.of(context).goNamed(SignupScreen.routeName);
  }
}

final loginScreenManagerProvider = StateNotifierProvider.autoDispose<
    LoginScreenManagerNotifier, LoginScreenState>((ref) {
  final link = ref.keepAlive();
  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });
  ref.onDispose(() {
    timer.cancel();
  });

  final LoginUsecase loginUsecase =
      ref.read<LoginUsecase>(loginUsecaseProvider);
  final OauthLoginUsecase oauthLoginUsecase =
      ref.read<OauthLoginUsecase>(oAuthUseCaseProvider);

  return LoginScreenManagerNotifier(loginUsecase, oauthLoginUsecase);
});
