import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:filtrek_app/features/fltrik/core/enums/StatusRequest.dart';
import 'package:filtrek_app/features/fltrik/core/functions/checkInternet.dart';

import 'package:http/http.dart' as http;

class Crud {
  Future<Either<StatusRequest, Map>> postData(String linkurl, Map data,
      [Map<String, String> aditionalHeaders = const {}]) async {
    try {
      if (await checkInternet()) {
        var response = await http.post(
          Uri.parse(linkurl),
          body: jsonEncode(data),
          headers: {"Content-Type": "application/json", ...aditionalHeaders},
        );

        if (response.statusCode == 200 ||
            response.statusCode == 201 ||
            response.statusCode == 202) {
          Map responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else if (response.statusCode == 404) {
          return Left(StatusRequest.NOTFOUND); // handle 404 specifically
        } else if (response.statusCode == 400) {
          return Left(StatusRequest.BADREQUEST);
        } else if (response.statusCode == 401) {
          return Left(StatusRequest.UNAUTHORIZED);
        } else if (response.statusCode == 403) {
          return Left(StatusRequest.FORBIDDEN);
        } else if (response.statusCode == 500) {
          return Left(StatusRequest.INTERNALSERVERERROR);
        } else {
          return Left(StatusRequest.SERVERFAILURE);
        }
      } else {
        // print("failure");
        return Left(StatusRequest.FAILURE);
      }
    } catch (e) {
      return left(StatusRequest.SERVERFAILURE);
    }
  }

  Future<Either<StatusRequest, Map>> getData(String linkurl,
      [Map<String, String> aditionalHeaders = const {}]) async {
    try {
      if (await checkInternet()) {
        final headers = {
          "Content-Type": "application/json",
          ...aditionalHeaders,
        };
        var response = await http.get(
          Uri.parse(linkurl),
          headers: headers,
        );
        if (response.statusCode == 200) {
          Map responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else if (response.statusCode == 404) {
          return Left(StatusRequest.NOTFOUND);
        } else if (response.statusCode == 400) {
          return Left(StatusRequest.BADREQUEST);
        } else if (response.statusCode == 401) {
          return Left(StatusRequest.UNAUTHORIZED);
        } else if (response.statusCode == 403) {
          return Left(StatusRequest.FORBIDDEN);
        } else if (response.statusCode == 500) {
          return Left(StatusRequest.INTERNALSERVERERROR);
        } else {
          return Left(StatusRequest.SERVERFAILURE);
        }
      } else {
        return Left(StatusRequest.FAILURE);
      }
    } catch (e) {
      return left(StatusRequest.SERVERFAILURE);
    }
  }

  Future<Either<StatusRequest, Map>> putData(String linkurl, Map data,
      [Map<String, String> aditionalHeaders = const {}]) async {
    try {
      if (await checkInternet()) {
        final headers = {
          "Content-Type": "application/json",
          ...aditionalHeaders,
        };
        var response = await http.put(
          Uri.parse(linkurl),
          body: jsonEncode(data),
          headers: headers,
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else if (response.statusCode == 404) {
          return Left(StatusRequest.NOTFOUND); // handle 404 specifically
        } else if (response.statusCode == 400) {
          return Left(StatusRequest.BADREQUEST);
        } else if (response.statusCode == 401) {
          return Left(StatusRequest.UNAUTHORIZED);
        } else if (response.statusCode == 403) {
          return Left(StatusRequest.FORBIDDEN);
        } else if (response.statusCode == 500) {
          return Left(StatusRequest.INTERNALSERVERERROR);
        } else {
          return Left(StatusRequest.SERVERFAILURE);
        }
      } else {
        return Left(StatusRequest.FAILURE);
      }
    } catch (e) {
      return left(StatusRequest.SERVERFAILURE);
    }
  }

  Future<Either<StatusRequest, Map>> deleteData(String linkurl) async {
    try {
      if (await checkInternet()) {
        var response = await http.delete(
          Uri.parse(linkurl),
          headers: {
            "Content-Type": "application/json",
          },
        );
        if (response.statusCode == 200 || response.statusCode == 204) {
          Map responsebody =
              response.body.isNotEmpty ? jsonDecode(response.body) : {};
          return Right(responsebody);
        } else if (response.statusCode == 404) {
          return Left(StatusRequest.NOTFOUND);
        } else if (response.statusCode == 400) {
          return Left(StatusRequest.BADREQUEST);
        } else if (response.statusCode == 401) {
          return Left(StatusRequest.UNAUTHORIZED);
        } else if (response.statusCode == 403) {
          return Left(StatusRequest.FORBIDDEN);
        } else if (response.statusCode == 500) {
          return Left(StatusRequest.INTERNALSERVERERROR);
        } else {
          return Left(StatusRequest.SERVERFAILURE);
        }
      } else {
        return Left(StatusRequest.FAILURE);
      }
    } catch (e) {
      return left(StatusRequest.SERVERFAILURE);
    }
  }
}
