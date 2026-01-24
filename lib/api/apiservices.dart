import 'package:dio/dio.dart';
import '../data/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  static const String baseUrl = "http://10.0.2.2:3000/api/";
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
    ),
  )..interceptors.add(AuthIntercreptor());

  static Future<Map<String, dynamic>> delete({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
  }) async {
    final token = await getToken();
    print('Token: $token');
    // // setupDio();
    final response = await _dio.delete(
      path,
      data: body,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }

  static Future<Map<String, dynamic>> get({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
  }) async {
    final token = await getToken();
    print('Token: $token');
    // // setupDio();
    final response = await _dio.get(
      path,
      data: body,
      queryParameters: query,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }

  static Future<Map<String, dynamic>> post({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
  }) async {
    final token = await getToken();
    print('Token: $token');
    // // setupDio();
    final response = await _dio.post(
      path,
      data: body,
      queryParameters: query,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }

  static Future<Map<String, dynamic>> put({
    required String path,
    dynamic body,
  }) async {
    final token = await getToken();
    print('Token: $token');
    // setupDio();
    final response = await _dio.put(
      path,
      data: body,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
    return response.data;
  }
}

class AuthIntercreptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('Token');
  }
}
