import 'dart:async';
import 'dart:developer';
import 'dart:io';


import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:osm_flutter/services/secure_storage.dart';

import '../utils/utils.dart';




class WebService {
  WebService();

  static final _instance = WebService();

  static WebService get instance => _instance;
  final _dio = Dio();
  SecureStorage secureStorage = SecureStorage();
  get({required NetworkRequest request}) async {
    if (kDebugMode) {
      log(request.toString());
    }

    try {
      Response response = await _dio
          .get(request.url, queryParameters: request.queryParameters, options:Options(
        headers: {
         "authorization":SecureStorage.token ?? ""
         // "authorization":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImN0eSI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6Iis5MSA2MzUzMzM3NDU3IiwiZW1haWwiOiJnYXVyYXZAZ21haWxjb20iLCJVc2VySUQiOiI1MSIsIlJvbGVzIjoiIiwiQXNzb2NpYXRpb25JRCI6IjkiLCJBc3NvY2lhdGlvblR5cGUiOiJBY2NvdW50IiwibmJmIjoxNjg4NTY1NTM2LCJleHAiOjE2ODg2NTE5MzYsImlhdCI6MTY4ODU2NTUzNn0.DVl6o8akQJq7hc2AxJPDWJcl006BEL7JpkkCvl4oMtA"
        }
      )).timeout(const Duration(seconds: 60));


      if (kDebugMode) {
        log(request.toResponseString(response.data));
      }

      return response.data;
    } on DioError catch (e) {
      decodeErrorResponse(error: e, request: request);
    } on SocketException {
      throw "Internet connection not available";
    } catch (e) {
      rethrow;
    }
  }

  post({required NetworkRequest request}) async {
    if (kDebugMode) {
      log(request.toString());
    }

    try {
      Response response = await _dio
          .post(request.url,queryParameters: request.queryParameters, data: request.data, options:Options(
              headers: {
                "authorization":"Bearer ${SecureStorage.token.toString()}"
              })).timeout(const Duration(seconds: 60));

              print("my associationID is ${SecureStorage.userID}");

              print("my token is ${SecureStorage.token} ======");
      if (kDebugMode) {
        log(request.toResponseString(response.data));
      }
      return response.data;
    } on DioException catch (e) {
      decodeErrorResponse(error: e, request: request);
    } on SocketException {
      throw "Internet connection not available";
    } catch (e) {

      if(e is TimeoutException) {
        throw "Request TimeOut.";
      }

      rethrow;
    }
  }

  decodeErrorResponse({required DioException error, required NetworkRequest request}) {

    if(error.response?.statusCode == 401) {
      throw UnauthorisedException();
    }

    if (kDebugMode) {
      log(request.toErrorString(error));
    }
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        throw 'Connection timeOut';
        case DioExceptionType.sendTimeout:
        // TODO: Handle this case.
        break;
      case DioExceptionType.receiveTimeout:
        throw 'Connection timeOut';
      case DioExceptionType.badCertificate:
        throw 'Connection timeOut';
      case DioExceptionType.badResponse:
        throw 'Something went wrong.';
      case DioExceptionType.cancel:
        throw 'Request Canceled by user';
      case DioExceptionType.connectionError:
        throw 'Something went wrong.';
      case DioExceptionType.unknown:

        if((error.message ?? "").contains("SocketException") || (error.error) is SocketException){
          throw "Internet connection not available";
        } else {
          throw "Something went wrong.";
        }

    }
  }
}

class NetworkRequest {
  final String url;
  final Map<String, dynamic>? queryParameters;
  final dynamic data;
  NetworkRequest({required this.url, this.queryParameters, this.data});

  String toErrorString(DioException error) {
    try {

      final uri = Uri.parse(url);

      final log = '''===⚠️ START ERROR ⚠️===
      
      API is for ${uri.pathSegments.last}
      URL = ${Uri(queryParameters: queryParameters, host: uri.host, path: uri.path, scheme: uri.scheme, port: uri.port, userInfo: uri.userInfo)}
      Data = ${getFormData()}
      Code = ${error.response?.statusCode}
      Error:
        Error Response is for this ${error.response?.toString()}
        Error = ${error.error?.toString()} - ${error.response?.statusCode}
        
===⚠️ END ERROR ⚠️===''';

      return log;
    } catch (e) {
      return '''===⚠️ START ERROR ⚠️===
      
      URL = $url
      Data = ${getFormData()}
      Error:
        Error Response is for this ${error.response?.toString()}
        Error = ${error.error?.toString()} - ${error.response?.statusCode}
        
===⚠️ END ERROR ⚠️===''';
    }
  }

  String toResponseString(dynamic response) {
    try {
      final uri = Uri.parse(url);

      final log = '''===👍️ START RESPONSE 👍===
        
      API is for ${uri.pathSegments.last}
      URL = ${Uri(queryParameters: queryParameters, host: uri.host, path: uri.path, scheme: uri.scheme, port: uri.port, userInfo: uri.userInfo)}
      Data = ${getFormData()}
      header data = 
      Response:
        $response
        
===👍️ END RESPONSE 👍===''';

      return log;
    } catch (e) {
      return '''===👍️ START RESPONSE 👍===
      
      URL = $url
      Data = ${getFormData()}
      Response:
        $response
        
===👍️ END RESPONSE 👍===
      ''';
    }
  }

  dynamic getFormData() {
    if(data is FormData) {
      final formData = data as FormData;
      return formData.fields;
    } else {
      return data;
    }
  }

  @override
  toString() {
    try {
      final uri = Uri.parse(url);

      final log = '''===🌐 START REQUEST 🌐===
      
      API is for ${uri.pathSegments.last}
      URL = ${Uri(queryParameters: queryParameters, host: uri.host, path: uri.path, scheme: uri.scheme, port: uri.port, userInfo: uri.userInfo)}
      Data = ${getFormData()}
      
      ===🌐 END REQUEST 🌐===''';

      return log;
    } catch (e) {
      return "API is for $url\nQuery = $queryParameters\n Data = $data";
    }
  }
}
