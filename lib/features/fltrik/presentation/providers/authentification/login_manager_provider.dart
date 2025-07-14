import 'package:filtrek_app/features/fltrik/domain/usecases/authentification/login_usecase.dart';
import 'package:filtrek_app/features/fltrik/presentation/providers/authentification/authentification_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreenState {
  final bool isLoading;
  final String? errorMessage;
  final bool isLoggedIn;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  LoginScreenState({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
    this.errorMessage,
    required this.isLoggedIn,
  });

  LoginScreenState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isLoggedIn,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    GlobalKey<FormState>? formKey,
  }) {
    return LoginScreenState(
      formKey: formKey ?? this.formKey,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}

class LoginScreenManagerNotifier extends StateNotifier<LoginScreenState> {
  final AuthentificationNotifier authentificationNotifier;

  LoginScreenManagerNotifier({required this.authentificationNotifier})
      : super(LoginScreenState(
          formKey: GlobalKey<FormState>(),
          emailController: TextEditingController(),
          passwordController: TextEditingController(),
          isLoading: false,
          isLoggedIn: false,
        ));

  @override
  void dispose() {
    // Dispose controllers to free up resources
    state.emailController.dispose();
    state.passwordController.dispose();
    super.dispose();
  }

  // Login method with form validation
  Future<void> login() async {
    if (state.formKey.currentState?.validate() ?? false) {
      state = state.copyWith(isLoading: true);
      try {
        final result = await authentificationNotifier.login(
          state.emailController.text,
          state.passwordController.text,
        );
        print(
            'Email: ${state.emailController.text}, Password: ${state.passwordController.text}');
        // state = state.copyWith(isLoading: false, isLoggedIn: result);
      } catch (error) {
        state =
            state.copyWith(isLoading: false, errorMessage: error.toString());
      }
    } else {
      state = state.copyWith(errorMessage: "Invalid form input");
    }
  }

  // Logout method
  void logout() {
    state = state.copyWith(isLoggedIn: false);
  }

  // Refresh method
  void refresh() {
    state = state.copyWith(isLoading: false, errorMessage: null);
  }
}

final loginScreenManagerProvider =
    StateNotifierProvider<LoginScreenManagerNotifier, LoginScreenState>((ref) {
  final authentificationNotifier =
      ref.read(authentificationNotifierProvider.notifier);

  return LoginScreenManagerNotifier(
      authentificationNotifier: authentificationNotifier);
});
