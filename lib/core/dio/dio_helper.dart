import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:workium/core/constants/app_config.dart';

class DioHelper {
  static late Dio dio;

  /// Initializes Dio with base options and logging interceptor
  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    // Add logging interceptor
    dio.interceptors.add(PrettyDioLogger(
        error: true,
        request: true,
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true
    ));
  }

  /// Sends a GET request
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {

      'Content-Type': 'application/json',
    };

    return await dio.get(url, queryParameters: query);
  }

  /// Sends a POST request
  static Future<Response> postData({
    required String url,
    required dynamic data,
    Map<String, dynamic>? query,
    String? token,
    bool isMultipart = false,
  }) async {
    dio.options.headers = {

      'Content-Type': isMultipart ? 'multipart/form-data' : 'application/json',
    };

    return await dio.post(url, data: data, queryParameters: query);
  }

  /// Sends a PUT request
  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
    bool isMultipart = false,
  }) async {
    dio.options.headers = {

      'Content-Type': isMultipart ? 'multipart/form-data' : 'application/json',
    };

    return await dio.put(url, data: data, queryParameters: query);
  }

  /// Sends a PATCH request
  static Future<Response> patchData({
    required String url,
    required dynamic data,
    Map<String, dynamic>? query,
    String? token,
    bool isMultipart = false,
  }) async {
    dio.options.headers = {

      'Content-Type': isMultipart ? 'multipart/form-data' : 'application/json',
    };

    return await dio.patch(url, data: data, queryParameters: query);
  }

  /// Sends a DELETE request
  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {

      'Content-Type': 'application/json',
    };

    return await dio.delete(url, queryParameters: query);
  }

  /// Upload file using multipart/form-data
  static Future<Response> uploadFile({
    required String url,
    required FormData formData,
    Map<String, dynamic>? query,
    String? token,
    ProgressCallback? onSendProgress,
  }) async {
    dio.options.headers = {
      'Content-Type': 'multipart/form-data',
    };

    return await dio.post(
      url,
      data: formData,
      queryParameters: query,
      onSendProgress: onSendProgress,
    );
  }
}