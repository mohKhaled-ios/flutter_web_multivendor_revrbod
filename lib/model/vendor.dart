// models/vendor_model.dart
class Vendor {
  final String id;
  final String fullname;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String? image; // لو ضفت صورة فيما بعد

  Vendor({
    required this.id,
    required this.fullname,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    this.image,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['_id'] ?? '',
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      locality: json['locality'] ?? '',
      image: json['image'], // لو موجودة
    );
  }
}
// models/ven