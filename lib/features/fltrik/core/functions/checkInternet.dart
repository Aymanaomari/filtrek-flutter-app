import 'dart:io';

Future<bool> checkInternet() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } catch (e) {
    return false;
  }
}
