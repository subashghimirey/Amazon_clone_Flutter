import 'dart:convert';
import 'package:ecommerce_app/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DjangoApi {
  final String baseUrl = "http://192.168.1.8:8000";

  // final String baseUrl = kIsWeb ? 'http://127.0.0.1:8000': 'http://192.168.1.2:8000';

  Future<Map<String, dynamic>> signup(
      String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/signup/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to Sign Up: ${response.statusCode} ${response.body}');
    }
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('auth_token', result['token']);
      await prefs.setString('username', result['username']);
      await prefs.setString('userType', result['type']);
      return result;
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token != null) {
      final response = await http.post(
        Uri.parse('$baseUrl/api/logout/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        },
      );

      if (response.statusCode == 200) {
        await prefs.remove('auth_token');
        // print('Logged out successfully');
      } else {
        throw Exception('Failed to logout: ${response.body}');
      }
    } else {
      throw Exception('No token found');
    }
  }

  Future<Map<String, dynamic>> checkLogin(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/check-login/'),
      headers: {
        'Authorization': 'Token $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to check login status: ${response.statusCode} ${response.body}');
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    // print(prefs.getString('username'));
    return prefs.getString('username');
  }

  Future<String?> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userType');
  }

  Future<void> addProduct(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await http.post(
      Uri.parse('$baseUrl/api/products/add/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      },
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add product: ${response.body}');
    }
  }

  Future<List<Map<String, dynamic>>> getProducts(
      {String? category, String? search}) async {
    String url = '$baseUrl/api/products/';
    Map<String, String> queryParams = {};

    if (category != null && category.isNotEmpty) {
      queryParams['category'] = category;
    }

    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search;
    }

    if (queryParams.isNotEmpty) {
      url += '?' + Uri(queryParameters: queryParams).query;
    }

    print(url);

    final response = await http.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> products = jsonDecode(response.body);
      return products
          .map((product) => product as Map<String, dynamic>)
          .toList();
    } else {
      throw Exception('Failed to fetch products: ${response.body}');
    }
  }

  Future<void> deleteProduct(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await http.delete(
      Uri.parse('$baseUrl/api/products/$productId/'),
      headers: {
        'Authorization': 'Token $token',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete product: ${response.body}');
    }
  }

  Future<void> addRating(int productId, int rating, String? review) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await http.post(
      Uri.parse('$baseUrl/api/products/$productId/ratings/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      },
      body: jsonEncode({
        'rating': rating,
        'review': review,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add rating: ${response.body}');
    }
  }

  Future<List<Map<String, dynamic>>> getRatings(int productId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/products/$productId/ratings/'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> ratings = jsonDecode(response.body);
      return ratings.map((rating) => rating as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to fetch ratings: ${response.body}');
    }
  }
}
