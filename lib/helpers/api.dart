import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tokokita/helpers/user_info.dart';
import 'package:tokokita/helpers/app_exception.dart' as app_exception;

class Api {
  /// POST Request
  Future<dynamic> post(String url, dynamic data) async {
    final token = await UserInfo().getToken();
    dynamic responseJson;

    try {
      final response = await http.post(
        Uri.parse(url),
        body: data,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw app_exception.FetchDataException("No Internet connection");
    }

    return responseJson;
  }

  /// GET Request
  Future<dynamic> get(String url) async {
    final token = await UserInfo().getToken();
    dynamic responseJson;

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw app_exception.FetchDataException("No Internet connection");
    }

    return responseJson;
  }

  /// PUT Request
  Future<dynamic> put(String url, dynamic data) async {
    final token = await UserInfo().getToken();
    dynamic responseJson;

    try {
      final response = await http.put(
        Uri.parse(url),
        body: data,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw app_exception.FetchDataException("No Internet connection");
    }

    return responseJson;
  }

  /// DELETE Request
  Future<dynamic> delete(String url) async {
    final token = await UserInfo().getToken();
    dynamic responseJson;

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw app_exception.FetchDataException("No Internet connection");
    }

    return responseJson;
  }

  /// Handle API Response
  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;

      case 400:
        throw app_exception.BadRequestException(response.body.toString());

      case 401:
      case 403:
        throw app_exception.UnauthorisedException(response.body.toString());

      case 422:
        throw app_exception.InvalidInputException(response.body.toString());

      case 500:
      default:
        throw app_exception.FetchDataException(
          "Error occurred during communication. StatusCode: ${response.statusCode}",
        );
    }
  }
}
