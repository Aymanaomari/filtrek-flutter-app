import 'package:shared_preferences/shared_preferences.dart';
import 'package:filtrek_app/core/constant/sp_keys.dart';

class AuthLocalDataSource {
  SharedPreferences? _sharedPreferences;

  AuthLocalDataSource();

  Future<SharedPreferences> get sharedPreferences async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }

  Future<void> saveAccessToken(String accessToken) async {
    try {
      final prefs = await sharedPreferences;
      await prefs.setString(SpKeys.accessToken, accessToken);
    } catch (e) {}
  }

  Future<String?> getAccessToken() async {
    try {
      final prefs = await sharedPreferences;
      return prefs.getString(SpKeys.accessToken);
    } catch (e) {
      return null;
    }
  }

  Future<void> clearAccessToken() async {
    try {
      final prefs = await sharedPreferences;
      await prefs.remove(SpKeys.accessToken);
    } catch (e) {
      return;
    }
  }

  Future<bool> isAuthenticated() async {
    try {
      final accessToken = await getAccessToken();
      return accessToken != null && accessToken.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
