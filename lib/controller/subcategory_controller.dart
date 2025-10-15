import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_web_multivendor_revrbod/model/subcategory.dart';
import 'package:flutter_web_multivendor_revrbod/service/manage_http_response.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class SubCategoryController {
  static const String baseUrl = "http://192.168.1.3:5000/api/subcategories";

  /// 📥 جلب كل الفئات الفرعية
  Future<List<SubCategory>> fetchAll() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((item) => SubCategory.fromJson(item)).toList();
    } else {
      throw Exception('فشل في تحميل الفئات الفرعية');
    }
  }

  /// 📥 جلب الفئات الفرعية حسب اسم القسم
  Future<List<SubCategory>> fetchByCategoryName(String categoryName) async {
    final response = await http.get(
      Uri.parse('$baseUrl/category/$categoryName'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((item) => SubCategory.fromJson(item)).toList();
    } else {
      throw Exception('فشل في تحميل الفئات الفرعية للقسم');
    }
  }

  /// ➕ إضافة فئة فرعية مع صورة (لـ Web باستخدام Uint8List)
  Future<void> createSubCategory({
    required BuildContext context,
    required String categoryId,
    required String categoryName,
    required String subcategoryName,
    required Uint8List imageFile,
  }) async {
    try {
      final uri = Uri.parse(baseUrl);
      var request = http.MultipartRequest('POST', uri);

      request.fields['categoryId'] = categoryId;
      request.fields['categoryname'] = categoryName;
      request.fields['subcategoryname'] = subcategoryName;

      // دعم الويب باستخدام Uint8List
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          imageFile,
          filename: '${DateTime.now().millisecondsSinceEpoch}.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      httpResponseHandler(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'تمت إضافة الفئة الفرعية بنجاح');
        },
      );
    } catch (e) {
      showSnackBar(context, 'حدث خطأ: $e');
    }
  }

  /// ✏️ تعديل فئة فرعية (مع أو بدون صورة)
  Future<void> updateSubCategory({
    required BuildContext context,
    required String id,
    required String categoryId,
    required String categoryName,
    required String subcategoryName,
    Uint8List? imageFile,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/$id');
      var request = http.MultipartRequest('PUT', uri);

      request.fields['categoryId'] = categoryId;
      request.fields['categoryname'] = categoryName;
      request.fields['subcategoryname'] = subcategoryName;

      if (imageFile != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'image',
            imageFile,
            filename: '${DateTime.now().millisecondsSinceEpoch}.jpg',
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      httpResponseHandler(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'تم تعديل الفئة الفرعية بنجاح');
        },
      );
    } catch (e) {
      showSnackBar(context, 'حدث خطأ: $e');
    }
  }

  /// 🗑️ حذف فئة فرعية
  Future<void> deleteSubCategory({
    required BuildContext context,
    required String id,
  }) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));

      httpResponseHandler(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'تم حذف الفئة الفرعية بنجاح');
        },
      );
    } catch (e) {
      showSnackBar(context, 'حدث خطأ: $e');
    }
  }
}
