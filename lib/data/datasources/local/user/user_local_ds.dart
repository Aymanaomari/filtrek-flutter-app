import 'dart:convert';
import 'package:filtrek_app/core/constant/sp_keys.dart';
import 'package:filtrek_app/data/models/user/current_user_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalDs {
  Future<CurrentUserResponseModel?> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userString = prefs.getString(SpKeys.userData);
      if (userString != null && userString.isNotEmpty) {
        final userJson = jsonDecode(userString);
        return CurrentUserResponseModel.fromJson(userJson);
      }
      return null;
    } catch (e) {
      print('Error getting current user from local storage: $e');
      return null;
    }
  }

  Future<void> saveCurrentUser(CurrentUserResponseModel user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userString = jsonEncode(user.toJson());
      await prefs.setString(SpKeys.userData, userString);
    } catch (e) {
      print('Error saving current user to local storage: $e');
    }
  }

  Future<void> clearCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(SpKeys.userData);
    } catch (e) {
      print('Error clearing current user from local storage: $e');
    }
  }
}
