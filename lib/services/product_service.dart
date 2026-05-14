import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
import 'auth_service.dart';

class ProductService {
  static const String baseUrl = 'https://task.itprojects.web.id';

  // Header dengan Bearer Token
  static Future<Map<String, String>> _authHeaders() async {
    final token = await AuthService.getToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // GET semua produk milik user yang login
  static Future<List<ProductModel>> getProducts() async {
    final url = Uri.parse('$baseUrl/api/products');
    final headers = await _authHeaders();

    final response = await http.get(url, headers: headers);
    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['success'] == true) {
      final List productsJson = data['data']['products'];
      return productsJson
          .map((item) => ProductModel.fromJson(item))
          .toList();
    } else {
      throw Exception(data['message'] ?? 'Gagal memuat produk');
    }
  }

  // POST tambah draft produk baru
  static Future<bool> addProduct({
    required String name,
    required int price,
    required String description,
  }) async {
    final url = Uri.parse('$baseUrl/api/products');
    final headers = await _authHeaders();

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({
        'name': name,
        'price': price,
        'description': description,
      }),
    );

    final data = jsonDecode(response.body);
    return response.statusCode == 201 && data['success'] == true;
  }

  // Delete produk
  static Future<bool> deleteProduct(int productId) async {
    final url = Uri.parse('$baseUrl/api/products/$productId');
    final headers = await _authHeaders();

    final response = await http.delete(url, headers: headers);
    final data = jsonDecode(response.body);
    return data['success'] == true;
  }

  // POST submit tugas akhir
  static Future<Map<String, dynamic>> submitTugas({
    required String name,
    required int price,
    required String description,
    required String githubUrl,
  }) async {
    final url = Uri.parse('$baseUrl/api/products/submit');
    final headers = await _authHeaders();

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({
        'name': name,
        'price': price,
        'description': description,
        'github_url': githubUrl,
      }),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 201 && data['success'] == true) {
      return {'success': true, 'message': data['message']};
    } else {
      return {
        'success': false,
        'message': data['message'] ?? 'Submit gagal',
      };
    }
  }
}