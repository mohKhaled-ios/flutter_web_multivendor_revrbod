class UserModel {
  final String id;
  final String fullname;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String? image; // لو عندك صورة للمستخدم
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.fullname,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    this.image,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      locality: json['locality'] ?? '',
      image: json['image'], // لو مفيش صورة ممكن تكون null
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
