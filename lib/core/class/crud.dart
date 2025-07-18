import 'dart:convert';

import 'package:filtrek_app/core/exceptions/http_exception.dart';
import 'package:filtrek_app/core/exceptions/network_exception.dart';
import 'package:filtrek_app/core/functions/checkInternet.dart';

import 'package:http/http.dart' as http;

class Crud {
  // Helper method to get error message from response body
  String _getErrorMessage(http.Response response) {
    try {
      final Map<String, dynamic> body = jsonDecode(response.body);
      final message = body['message'];
      if (message is List) {
        // Join array messages line by line
        return message.join('\n');
      }
      return message ?? body['error'] ?? 'Request failed';
    } catch (e) {
      return 'Request failed';
    }
  }

  // Helper method to get response body as Map
  Map<String, dynamic>? _getResponseBody(http.Response response) {
    try {
      return jsonDecode(response.body);
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> postData(String linkurl, Map data,
      [Map<String, String> additionalHeaders = const {}]) async {
    try {
      if (!await checkInternet()) {
        throw NetworkException('No internet connection');
      }
      var response = await http.post(
        Uri.parse(linkurl),
        body: jsonEncode(data),
        headers: {"Content-Type": "application/json", ...additionalHeaders},
      );
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        // Handle empty response body
        if (response.body.isEmpty) {
          return {};
        }
        try {
          return jsonDecode(response.body);
        } catch (jsonError) {
          return {'message': response.body};
        }
      } else {
        print(response.body);

        throw HttpException(
          statusCode: response.statusCode,
          message: _getErrorMessage(response),
          responseBody: _getResponseBody(response),
        );
      }
    } catch (e) {
      if (e is HttpException || e is NetworkException) {
        rethrow;
      }
      throw NetworkException('Request failed: $e');
    }
  }

  Future<Map<String, dynamic>> getData(String linkurl,
      [Map<String, String> additionalHeaders = const {}]) async {
    try {
      if (!await checkInternet()) {
        throw NetworkException('No internet connection');
      }

      final headers = {
        "Content-Type": "application/json",
        ...additionalHeaders,
      };
      var response = await http.get(
        Uri.parse(linkurl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw HttpException(
          statusCode: response.statusCode,
          message: _getErrorMessage(response),
          responseBody: _getResponseBody(response),
        );
      }
    } catch (e) {
      if (e is HttpException || e is NetworkException) {
        rethrow;
      }
      throw NetworkException('Request failed: $e');
    }
  }

  Future<Map<String, dynamic>> putData(String linkurl, Map data,
      [Map<String, String> additionalHeaders = const {}]) async {
    try {
      if (!await checkInternet()) {
        throw NetworkException('No internet connection');
      }

      final headers = {
        "Content-Type": "application/json",
        ...additionalHeaders,
      };
      var response = await http.put(
        Uri.parse(linkurl),
        body: jsonEncode(data),
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw HttpException(
          statusCode: response.statusCode,
          message: _getErrorMessage(response),
          responseBody: _getResponseBody(response),
        );
      }
    } catch (e) {
      if (e is HttpException || e is NetworkException) {
        rethrow;
      }
      throw NetworkException('Request failed: $e');
    }
  }

  Future<Map<String, dynamic>> deleteData(String linkurl,
      [Map<String, String> additionalHeaders = const {}]) async {
    try {
      if (!await checkInternet()) {
        throw NetworkException('No internet connection');
      }

      var response = await http.delete(
        Uri.parse(linkurl),
        headers: {
          "Content-Type": "application/json",
          ...additionalHeaders,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return response.body.isNotEmpty ? jsonDecode(response.body) : {};
      } else {
        throw HttpException(
          statusCode: response.statusCode,
          message: _getErrorMessage(response),
          responseBody: _getResponseBody(response),
        );
      }
    } catch (e) {
      if (e is HttpException || e is NetworkException) {
        rethrow;
      }
      throw NetworkException('Request failed: $e');
    }
  }

  Future<Map<String, dynamic>> patchData(String linkurl, Map data,
      [Map<String, String> additionalHeaders = const {}]) async {
    try {
      if (!await checkInternet()) {
        throw NetworkException('No internet connection');
      }
      final headers = {
        "Content-Type": "application/json",
        ...additionalHeaders,
      };
      var response = await http.patch(
        Uri.parse(linkurl),
        body: jsonEncode(data),
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw HttpException(
          statusCode: response.statusCode,
          message: _getErrorMessage(response),
          responseBody: _getResponseBody(response),
        );
      }
    } catch (e) {
      if (e is HttpException || e is NetworkException) {
        rethrow;
      }
      throw NetworkException('Request failed: $e');
    }
  }

  // ...existing code...

  Future<Map<String, dynamic>> uploadFormData(
    String url,
    Map<String, String> fields,
    List<http.MultipartFile> files, [
    Map<String, String> additionalHeaders = const {},
  ]) async {
    try {
      if (!await checkInternet()) {
        throw NetworkException('No internet connection');
      }

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields.addAll(fields);
      request.files.addAll(files);
      request.headers.addAll(additionalHeaders);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        return response.body.isNotEmpty ? jsonDecode(response.body) : {};
      } else {
        throw HttpException(
          statusCode: response.statusCode,
          message: _getErrorMessage(response),
          responseBody: _getResponseBody(response),
        );
      }
    } catch (e) {
      if (e is HttpException || e is NetworkException) {
        rethrow;
      }
      throw NetworkException('Request failed: $e');
    }
  }

// ...existing code...
}
