import 'package:filtrek_app/features/fltrik/data/repositories/authentification_repository_imp.dart';
import 'package:filtrek_app/features/fltrik/domain/repositories/authentification_repository.dart';
import 'package:filtrek_app/features/fltrik/domain/usecases/authentification/login_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authentificationRepositoryProvider = Provider<AuthentificationRepository>(
    (ref) => AuthentificationRepositoryImp());

final loginUsecase = Provider<LoginUsecase>((ref) {
  return LoginUsecase(
      authentificationRepository: ref.read(authentificationRepositoryProvider));
});

final authentificationNotifierProvider =
    StateNotifierProvider<AuthentificationNotifier, AsyncValue<bool>>((ref) {
  final loginUsecaseInstance = ref.read(loginUsecase);

  return AuthentificationNotifier(loginUsecaseInstance);
});

class AuthentificationNotifier extends StateNotifier<AsyncValue<bool>> {
  final LoginUsecase _loginUsecase;

  AuthentificationNotifier(this._loginUsecase)
      : super(const AsyncValue.loading());

  // Login method
  Future<bool> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final bool result = await _loginUsecase.call(email, password);
      state = AsyncValue.data(result);
      return result;
    } catch (error, stackTrace) {
      throw Exception(error);
    }
  }
}
