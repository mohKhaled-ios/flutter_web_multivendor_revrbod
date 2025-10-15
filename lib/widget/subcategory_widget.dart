// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter_web_multivendor_revrbod/controller/subcategory_controller.dart';
// import 'package:flutter_web_multivendor_revrbod/model/subcategory.dart';

// class SubcategoryWidget extends StatefulWidget {
//   const SubcategoryWidget({super.key});

//   @override
//   State<SubcategoryWidget> createState() => _SubcategoryWidgetState();
// }

// class _SubcategoryWidgetState extends State<SubcategoryWidget> {
//   late Future<List<SubCategory>> futuresubCategories;

//   @override
//   void initState() {
//     super.initState();
//     futuresubCategories = SubCategoryController().fetchAll();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<SubCategory>>(
//       future: futuresubCategories,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CircularProgressIndicator(color: Colors.blue),
//           );
//         } else if (snapshot.hasError) {
//           return Center(child: Text("حدث خطأ: ${snapshot.error}"));
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(child: Text("لا توجد فئات فرعية متاحة"));
//         } else {
//           final subcategories = snapshot.data!;
//           return GridView.builder(
//             padding: const EdgeInsets.all(8),
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: subcategories.length,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 5,
//               crossAxisSpacing: 16,
//               mainAxisSpacing: 16,
//               childAspectRatio: 0.8,
//             ),
//             itemBuilder: (context, i) {
//               return Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 elevation: 3,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Image.network(
//                         'http://192.168.1.3:5000/uploads/subcategories/${subcategories[i].image}',
//                         width: 100,
//                         height: 100,
//                         fit: BoxFit.cover,
//                         errorBuilder:
//                             (context, error, stackTrace) => const Icon(
//                               Icons.image_not_supported,
//                               size: 100,
//                               color: Colors.grey,
//                             ),
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       subcategories[i].subcategoryName,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(fontWeight: FontWeight.w600),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       subcategories[i].categoryName,
//                       style: const TextStyle(fontSize: 12, color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_web_multivendor_revrbod/controller/subcategory_controller.dart';
import 'package:flutter_web_multivendor_revrbod/model/subcategory.dart';

class SubcategoryWidget extends StatefulWidget {
  const SubcategoryWidget({super.key});

  @override
  State<SubcategoryWidget> createState() => _SubcategoryWidgetState();
}

class _SubcategoryWidgetState extends State<SubcategoryWidget> {
  late Future<List<SubCategory>> futuresubCategories;

  @override
  void initState() {
    super.initState();
    futuresubCategories = SubCategoryController().fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SubCategory>>(
      future: futuresubCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.blue),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("حدث خطأ: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("لا توجد فئات فرعية متاحة"));
        } else {
          final subcategories = snapshot.data!;
          String baseUrl = 'http://192.168.1.3:5000'; // تأكد أنه نفس IP الجهاز

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: subcategories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, i) {
              final imagePath = subcategories[i].image;
              final fullImageUrl = "$baseUrl$imagePath";

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        fullImageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.broken_image,
                            size: 100,
                            color: Colors.grey,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subcategories[i].subcategoryName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subcategories[i].categoryName,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
