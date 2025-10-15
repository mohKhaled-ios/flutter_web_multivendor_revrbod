class SubCategory {
  final String id;
  final String categoryId;
  final String categoryName;
  final String image;
  final String subcategoryName;
  final DateTime createdAt;
  final DateTime updatedAt;

  SubCategory({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.image,
    required this.subcategoryName,
    required this.createdAt,
    required this.updatedAt,
  });

  // من JSON إلى كائن Dart
  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['_id'],
      categoryId: json['categoryId'],
      categoryName: json['categoryname'],
      image: json['image'] ?? '',
      subcategoryName: json['subcategoryname'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // من كائن Dart إلى JSON (للاستخدام في الإرسال للـ backend)
  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'categoryname': categoryName,
      'image': image,
      'subcategoryname': subcategoryName,
    };
  }
}
