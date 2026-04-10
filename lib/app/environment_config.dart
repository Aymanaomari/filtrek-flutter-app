import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentConfig {
  EnvironmentConfig._();

  static late String _apiBaseUrl;

  static Future<void> init() async {
    await dotenv.load(
      fileName: ".dev.env",
    );

    _apiBaseUrl = dotenv.get(
      'API_BASE_URL',
      fallback: "http://test.com",
    );
  }

  static String get apiBaseUrlValue => _apiBaseUrl;
}
