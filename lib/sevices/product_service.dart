import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_model.dart';

class ProductService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://bb3-api.ashwinsrivastava.com",
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 5000),
    ),
  );
  static Future<void> _addAuthTokenToHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs
        .getString('accessToken'); 
    // print(token);
    if (token != null) {
     
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  static Future<List<Product>> fetchAllProducts({
    int? page,
    int? limit,
    String? search,
    String? sort,
  }) async {
    try {
      await _addAuthTokenToHeaders();
      final response = await _dio.get(
        '/admin/product',
        queryParameters: {
          if (page != null) 'page': page,
          if (limit != null) 'limit': limit,
          if (search != null) 'titles': search,
          if (sort != null) 'sort': sort,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  static Future<Product?> fetchProductDetails(String productId) async {
    const String baseUrl =
        'https://bb3-api.ashwinsrivastava.com/admin/product/';
    try {
      final response = await _dio.get('$baseUrl$productId');
      if (response.statusCode == 200 && response.data['success'] == true) {
        return Product.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to fetch product details');
      }
    } catch (e) {
      if (kDebugMode) {
        print("in get product with id $e");
      }
    }
    return null;
  }
}
