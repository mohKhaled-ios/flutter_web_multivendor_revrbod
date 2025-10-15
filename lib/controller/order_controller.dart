import 'dart:convert';
import 'package:flutter_web_multivendor_revrbod/model/order.dart';
import 'package:http/http.dart' as http;

class OrderService {
  static const String baseUrl = "http://localhost:5000/api/orders";

  Future<List<OrderModel>> getAllOrders() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      return jsonData.map((e) => OrderModel.fromJson(e)).toList();
    } else {
      throw Exception("فشل في جلب الطلبات");
    }
  }

  Future<void> deleteOrder(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    if (response.statusCode != 200) {
      throw Exception("فشل في حذف الطلب");
    }
  }
}
