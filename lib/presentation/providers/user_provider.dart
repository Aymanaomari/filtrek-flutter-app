import 'dart:async';

import 'package:filtrek_app/core/class/crud.dart';
import 'package:filtrek_app/core/class/googleSignin.dart';
import 'package:filtrek_app/core/exceptions/http_exception.dart';
import 'package:filtrek_app/core/exceptions/network_exception.dart';
import 'package:filtrek_app/features/authentication/data/datasources/local/auth_local_datasource.dart';
import 'package:filtrek_app/data/datasources/local/user/user_local_ds.dart';
import 'package:filtrek_app/data/datasources/remote/user_remote_ds.dart';
import 'package:filtrek_app/data/repositories/user_repository_imp.dart';
import 'package:filtrek_app/domain/entities/memberships/current_user_membership_entity.dart';
import 'package:filtrek_app/domain/repositories/user_repository.dart';
import 'package:filtrek_app/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:filtrek_app/domain/usecases/membership/get_current_user_membership_usecase.dart';
import 'package:filtrek_app/domain/usecases/user/get_current_user_usecase.dart';
import 'package:filtrek_app/domain/entities/user/current_user_response_entity.dart';
import 'package:filtrek_app/domain/usecases/user/update_current_user_usecase.dart';
import 'package:filtrek_app/domain/usecases/user/upload_profile_image_usecase.dart';
import 'package:filtrek_app/features/authentication/presentation/providers/auth_provider.dart';
import 'package:filtrek_app/presentation/providers/membership_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:filtrek_app/domain/entities/user/current_user_update_entity.dart';

// User State to hold current user data and loading state
class UserState {
  final CurrentUserResponseEntity? currentUser;
  final CurrentUserMembershipEntity? currentUserMembership;
  final bool isLoading;
  final String? errorMessage;
  final bool isMembershipLoading;
  final bool isLogoutLoading;
  final bool updateIsLoading;
  final CurrentUserUpdateEntity currentUserUpdate;

  const UserState(
      {this.currentUser,
      this.currentUserMembership,
      this.isLoading = false,
      this.errorMessage,
      this.isMembershipLoading = false,
      this.isLogoutLoading = false,
      this.updateIsLoading = false,
      required this.currentUserUpdate});

  UserState copyWith({
    CurrentUserResponseEntity? currentUser,
    CurrentUserMembershipEntity? currentUserMembership,
    bool? isLoading,
    String? errorMessage,
    bool? isMembershipLoading,
    bool? isLogoutLoading,
    bool? updateIsLoading,
    CurrentUserUpdateEntity? currentUserUpdate,
    bool clearMembership = false, // Add this parameter
  }) {
    return UserState(
      currentUser: currentUser ?? this.currentUser,
      currentUserMembership: clearMembership
          ? null
          : (currentUserMembership ?? this.currentUserMembership),
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isMembershipLoading: isMembershipLoading ?? this.isMembershipLoading,
      isLogoutLoading: isLogoutLoading ?? this.isLogoutLoading,
      updateIsLoading: updateIsLoading ?? this.updateIsLoading,
      currentUserUpdate: currentUserUpdate ?? this.currentUserUpdate,
    );
  }
}

class UserStateNotifier extends StateNotifier<UserState> {
  final GetCurrentUserUsecase _getCurrentUserUsecase;
  final GetCurrentUserMembershipUsecase _getCurrentUserMembershipUsecase;
  final UpdateCurrentUserUsecase _updateCurrentUserUsecase;
  final LogoutUsecase _logoutUsecase;

  UserStateNotifier(
      this._getCurrentUserUsecase,
      this._getCurrentUserMembershipUsecase,
      this._logoutUsecase,
      this._updateCurrentUserUsecase)
      : super(UserState(currentUserUpdate: CurrentUserUpdateEntity())) {
    loadCurrentUser();
    loadMembership();
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setError(String? error) {
    state = state.copyWith(errorMessage: error, isLoading: false);
  }

  void setCurrentUser(CurrentUserResponseEntity? user) {
    state = state.copyWith(
      currentUser: user,
      isLoading: false,
      errorMessage: null,
    );
  }

  void setCurrentUserMembership(CurrentUserMembershipEntity? membership) {
    state = state.copyWith(
      currentUserMembership: membership,
      isLoading: false,
      errorMessage: null,
    );
  }

  Future loadCurrentUser() async {
    if (state.currentUser != null) {
      // User already loaded, skipping...
      return;
    }
    try {
      setLoading(true);
      final CurrentUserResponseEntity? user =
          await _getCurrentUserUsecase.call();
      if (user != null) {
        setCurrentUser(user);
      } else {
        setCurrentUser(null);
      }
    } on NetworkException {
      rethrow;
    } catch (e) {
      setError(e.toString());
    }
  }

  Future<void> refreshCurrentUser() async {
    try {
      setLoading(true);
      final CurrentUserResponseEntity? user =
          await _getCurrentUserUsecase.call();
      if (user != null) {
        setCurrentUser(user);
      } else {
        setCurrentUser(null);
      }
    } on NetworkException {
      rethrow;
    } catch (e) {
      setError(e.toString());
    }
  }

  Future<void> loadMembership() async {
    if (state.currentUserMembership != null) {
      // Membership already loaded, skipping...
      return;
    }
    try {
      state = state.copyWith(isMembershipLoading: true);
      final CurrentUserMembershipEntity? membership =
          await _getCurrentUserMembershipUsecase.call();
      setCurrentUserMembership(membership);
      state = state.copyWith(isMembershipLoading: false);
    } on HttpException catch (e) {
      state = state.copyWith(isMembershipLoading: false);
      if (e.statusCode == 404) {
        setCurrentUserMembership(null);
      }
    } on NetworkException {
      rethrow;
    } catch (e) {
      state = state.copyWith(isMembershipLoading: false);
      setError(e.toString());
    }
  }

  updateGender(String gender) {
    if (state.currentUser != null) {
      final updatedUser = state.currentUser!.copyWith(gender: gender);
      final updatedPatch = state.currentUserUpdate.copyWith(gender: gender);
      state = state.copyWith(
          currentUser: updatedUser, currentUserUpdate: updatedPatch);
    }
  }

  void updateAge(int age) {
    if (state.currentUser != null) {
      final updatedUser = state.currentUser!.copyWith(age: age);
      final updatedPatch = state.currentUserUpdate!.copyWith(age: age);
      state = state.copyWith(
          currentUser: updatedUser, currentUserUpdate: updatedPatch);
    }
  }

  void updateWeight(double weight) {
    if (state.currentUser != null) {
      final updatedUser = state.currentUser!.copyWith(weight: weight);
      final updatedPatch = state.currentUserUpdate.copyWith(weight: weight);
      state = state.copyWith(
          currentUser: updatedUser, currentUserUpdate: updatedPatch);
    }
  }

  Future<void> refreshMembership() async {
    try {
      state = state.copyWith(isMembershipLoading: true);
      final CurrentUserMembershipEntity? membership =
          await _getCurrentUserMembershipUsecase.call();
      setCurrentUserMembership(membership);
      state = state.copyWith(isMembershipLoading: false);
    } on HttpException catch (e) {
      state = state.copyWith(isMembershipLoading: false);
      if (e.statusCode == 404) {
        setCurrentUserMembership(null);
      }
    } on NetworkException {
      rethrow;
    } catch (e) {
      state = state.copyWith(isMembershipLoading: false);
      setError(e.toString());
    }
  }

  void clear() {
    state = UserState(
      currentUser: null,
      currentUserMembership: null,
      errorMessage: null,
      isLoading: false,
      isMembershipLoading: false,
      isLogoutLoading: false,
      updateIsLoading: false,
      currentUserUpdate: CurrentUserUpdateEntity(),
    );
  }

  Future<void> logout() async {
    try {
      clear();
      await _logoutUsecase.call();
      try {
        await GoogleSigninApi.logout();
      } catch (e) {
        setError('Google Sign-In logout failed: $e');
      }
      state = state.copyWith(isLogoutLoading: false);
    } on NetworkException {
      rethrow;
    } catch (e) {
      state = state.copyWith(isLogoutLoading: false);
      setError('Logout failed: $e');
    }
  }

  Future<void> updateCurrentUser() async {
    if (state.currentUser == null) return;
    try {
      state = state.copyWith(updateIsLoading: true);
      final updatedUser =
          await _updateCurrentUserUsecase.call(state.currentUserUpdate);
      setCurrentUser(updatedUser);
      state = state.copyWith(
          updateIsLoading: false, currentUserUpdate: CurrentUserUpdateEntity());
    } on NetworkException {
      rethrow;
    } catch (e) {
      state = state.copyWith(updateIsLoading: false);
      setError('Failed to update user: $e');
    }
  }
}

// Providers
final userRemoteDataSourceProvider =
    Provider<UserRemoteDs>((ref) => UserRemoteDs(crud: Crud()));

final userLocalDataSourceProvider =
    Provider<UserLocalDs>((ref) => UserLocalDs());

final authLocalDataSourceProvider =
    Provider<AuthLocalDataSource>((ref) => AuthLocalDataSource());

final userRepositoryProvider = Provider<UserRepository>((ref) =>
    UserRepositoryImp(
        remoteDs: ref.read(userRemoteDataSourceProvider),
        localDs: ref.read(userLocalDataSourceProvider),
        authLocalDs: ref.read(authLocalDataSourceProvider)));

final getCurrentUserUsecaseProvider = Provider<GetCurrentUserUsecase>(
    (ref) => GetCurrentUserUsecase(userRepo: ref.read(userRepositoryProvider)));

final getCurrentUserMembershipUsecaseProvider =
    Provider<GetCurrentUserMembershipUsecase>((ref) =>
        GetCurrentUserMembershipUsecase(
            memeberShipRepository: ref.read(memebrShipReppositoryProvider)));

final updateCurrentUserUsercaseProvider = Provider<UpdateCurrentUserUsecase>(
    (ref) => UpdateCurrentUserUsecase(
        userRepository: ref.read(userRepositoryProvider)));

final uploadProfileImageUsecaseProvider = Provider<UploadProfileImageUsecase>(
    (ref) => UploadProfileImageUsecase(
        userRepository: ref.read(userRepositoryProvider)));

// StateNotifier Provider for managing current user state
final userStateProvider =
    StateNotifierProvider.autoDispose<UserStateNotifier, UserState>(
  (ref) {
    final link = ref.keepAlive();
    final timer = Timer(const Duration(seconds: 10), () {
      link.close();
    });
    ref.onDispose(() {
      timer.cancel();
    });
    return UserStateNotifier(
        ref.read(getCurrentUserUsecaseProvider),
        ref.read(getCurrentUserMembershipUsecaseProvider),
        ref.read(logoutUsecaseProvider),
        ref.read(updateCurrentUserUsercaseProvider));
  },
);
