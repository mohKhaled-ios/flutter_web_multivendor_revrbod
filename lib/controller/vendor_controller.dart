// services/vendor_service.dart
import 'dart:convert';
import 'package:flutter_web_multivendor_revrbod/model/vendor.dart';
import 'package:http/http.dart' as http;

class VendorService {
  static const String baseUrl = 'http://localhost:5000'; // غيّرها حسب السيرفر

  Future<List<Vendor>> getAllVendors() async {
    final url = Uri.parse('$baseUrl/api/vendor/auth/all');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Vendor.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load vendors: ${response.statusCode}');
    }
  }
}
