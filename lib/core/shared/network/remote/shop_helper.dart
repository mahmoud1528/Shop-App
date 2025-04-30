import 'package:dio/dio.dart';

class ShopHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getDate({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? lang ,
    String? token,
  }) {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang ?? '',
      'Authorization': token ?? '',
    };

    return dio.get(url, queryParameters: query, data: data);
  }

  static Future<Response> postDate({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? lang ,
    String? token,
  }) {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang ?? '',
      'Authorization': token ?? '',
    };

    return dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> putDate({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? lang ,
    String? token,
  }) {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang ?? '',
      'Authorization': token ?? '',
    };

    return dio.put(url, queryParameters: query, data: data);
  }
}
