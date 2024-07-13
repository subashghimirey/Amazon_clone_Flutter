import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DjangoApi {
  final String baseUrl = "http://192.168.1.2:8000";

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
}
