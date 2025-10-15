// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_web_multivendor_revrbod/controller/banner_controller.dart';

// class UbloadBanners extends StatefulWidget {
//   static const String id = '/ubloadbannerscreens';
//   const UbloadBanners({super.key});

//   @override
//   State<UbloadBanners> createState() => _UbloadBannersState();
// }

// class _UbloadBannersState extends State<UbloadBanners> {
//   BannerController _bannerController = BannerController();
//   dynamic _image;
//   pickimage() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//       allowMultiple: false,
//     );

//     if (result != null && result.files.single.path != null) {
//       setState(() {
//         _image = result.files.first.bytes;
//       });
//     } else {
//       // المستخدم لغى الاختيار
//       return null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             alignment: Alignment.topLeft,
//             child: Text(
//               'banner',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
//             ),
//           ),
//         ),
//         Divider(color: Colors.grey, thickness: 2),
//         Row(
//           children: [
//             Container(
//               width: 150,
//               height: 150,
//               decoration: BoxDecoration(
//                 color: Colors.grey,
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child:
//                   _image != null
//                       ? Image.memory(_image, fit: BoxFit.cover)
//                       : Center(child: Text('Banner Image')),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ElevatedButton(
//                 onPressed: () {
//                   _bannerController.uploadBannerWeb(imageBytes: imageBytes, fileName: fileName, context: context)
//                 },
//                 child: Text('Save'),
//               ),
//             ),
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ElevatedButton(
//             onPressed: () {
//               pickimage();
//             },
//             child: Text('Pick Image'),
//           ),
//         ),
//       ],
//     );
//   }
// }
// import 'dart:typed_data';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_web_multivendor_revrbod/controller/banner_controller.dart';

// class UbloadBanners extends StatefulWidget {
//   static const String id = '/ubloadbannerscreens';
//   const UbloadBanners({super.key});

//   @override
//   State<UbloadBanners> createState() => _UbloadBannersState();
// }

// class _UbloadBannersState extends State<UbloadBanners> {
//   final BannerController _bannerController = BannerController();

//   String? _fileName;

//   Future<void> pickImage() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//       allowMultiple: false,
//     );

//     if (result != null) {
//       setState(() {
//         _imageBytes = result.files.first.bytes!;
//         _fileName = result.files.first.name;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       // مهم لتجنب overflow
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Text(
//               'Banner',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
//             ),
//           ),
//           const Divider(color: Colors.grey, thickness: 2),
//           Row(
//             children: [
//               Container(
//                 width: 150,
//                 height: 150,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child:
//                     _imageBytes != null
//                         ? Image.memory(_imageBytes!, fit: BoxFit.cover)
//                         : const Center(child: Text('Banner Image')),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ElevatedButton(
//                 onPressed: (){

//                 },
//                   child: const Text('Save'),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ElevatedButton(
//               onPressed: pickImage,
//               child: const Text('Pick Image'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_multivendor_revrbod/controller/banner_controller.dart';
import 'package:flutter_web_multivendor_revrbod/views/Side_bars_screens/banner_widget.dart';

class UploadBanners extends StatefulWidget {
  static const String id = '/uploadbannerscreen';
  const UploadBanners({super.key});

  @override
  State<UploadBanners> createState() => _UploadBannersState();
}

class _UploadBannersState extends State<UploadBanners> {
  final BannerController _bannerController = BannerController();

  Uint8List? _imageBytes;
  String? _fileName;

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.first.bytes != null) {
      setState(() {
        _imageBytes = result.files.first.bytes!;
        _fileName = result.files.first.name;
      });
    }
  }

  void uploadBanner() {
    if (_imageBytes != null) {
      _bannerController.uploadBanner(
        context: context,
        bannerImage: _imageBytes!,
        fileName: _fileName ?? 'banner.jpg',
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('📷 يرجى اختيار صورة أولاً')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Banner',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          const Divider(thickness: 2),
          Row(
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(5),
                ),
                child:
                    _imageBytes != null
                        ? Image.memory(_imageBytes!, fit: BoxFit.cover)
                        : const Center(child: Text('Banner Image')),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: uploadBanner,
                child: const Text('Save'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: pickImage, child: const Text('Pick Image')),
          Divider(color: Colors.grey),
          BannerWidget(),
        ],
      ),
    );
  }
}
