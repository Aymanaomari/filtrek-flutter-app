import 'package:google_sign_in/google_sign_in.dart';

class GoogleSigninApi {
  static final _googleSigning = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() => _googleSigning.signIn();

  static Future<void> logout() async {
    await _googleSigning.signOut();
  }
}
