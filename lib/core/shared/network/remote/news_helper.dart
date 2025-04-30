import 'package:dio/dio.dart';

class NewsHelper{
  static late Dio dio;

  static init() {
    dio=Dio(
        BaseOptions(
          baseUrl: 'https://newsapi.org/',
          receiveDataWhenStatusError: true,
        )
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String,dynamic> query,
}) async {
    return await dio.get(url,queryParameters: query);
  }
}

//https://newsapi.org/v2/top-headlines?country=us&apiKey=bc96824a5548417b948ac290fd7fb3dd

//baseUrl:  https://newsapi.org/
//path: v2/top-headlines?
//query: country=us&apiKey=bc96824a5548417b948ac290fd7fb3dd