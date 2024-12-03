import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/login_response.dart';


class AuthService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://bb3-api.ashwinsrivastava.com",
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 5000),
    ),
  );

  static Future<LoginResponse?> login(String email, String password) async {
    try {
      final response = await _dio.post(
        "/admin/auth/login",
        data: {"email": email, "password": password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (kDebugMode) {
        print('service invoked');
        print(response.statusCode);
      }
      if (response.statusCode == 201) {
        // if (kDebugMode) {
        //   print(response.data);
        // }
        final perfs = await SharedPreferences.getInstance();
        perfs.setString(
            "accessToken", response.data['data']['tokens']['accessToken']);
        perfs.setString(
            "refreshToken", response.data['data']['tokens']['refreshToken']);
        final token = perfs
            .getString('accessToken'); // Retrieve token from SharedPreferences
        print(token);
        // SecureStorage.saveTokens(response.data['data']['tokens']['accessToken'],
        //     response.data['data']['tokens']['refreshToken']);
        if (kDebugMode) {
          print(response.data.runtimeType);
        }
        return LoginResponse.fromJson(response.data);
      }
    } catch (e) {
      // Handle Dio-specific errors
      if (kDebugMode) {
        print("ine api error: $e");
      }
    }
    return null;
  }

  static Future<void> logOut() async {
    // SecureStorage.clearTokens();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('accessToken');
    prefs.remove('refreshToken');
  }
}


// Dio _dio() {
//   final dio = Dio(BaseOptions(
//     baseUrl: ApiConstants.baseUrl,
//     connectTimeout: const Duration(milliseconds: 5000),
//     receiveTimeout: const Duration(milliseconds: 5000),
//   ));

//   dio.interceptors.add(InterceptorsWrapper(
//     onRequest: (options, handler) {
//       print('Request: ${options.method} ${options.uri}');
//       return handler.next(options);
//     },
//     onResponse: (response, handler) {
//       print('Response: ${response.statusCode} ${response.data}');
//       return handler.next(response);
//     },
//     onError: (DioException e, handler) {
//       print('Error: ${e.response?.statusCode} ${e.message}');
//       return handler.next(e);
//     },
//   ));

//   return dio;
// }
