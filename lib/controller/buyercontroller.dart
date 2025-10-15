import 'dart:convert';
import 'package:flutter_web_multivendor_revrbod/model/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  static const String baseUrl = 'http://localhost:5000/api/auth';

  Future<List<UserModel>> fetchAllUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/all'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => UserModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
