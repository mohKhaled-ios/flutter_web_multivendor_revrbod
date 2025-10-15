import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_multivendor_revrbod/controller/category_controller.dart';
import 'package:flutter_web_multivendor_revrbod/service/manage_http_response.dart';
import 'package:flutter_web_multivendor_revrbod/widget/category_widget.dart';

class CategoryScreens extends StatefulWidget {
  static const String id = '/categoryscreens';
  const CategoryScreens({super.key});

  @override
  State<CategoryScreens> createState() => _CategoryScreensState();
}

class _CategoryScreensState extends State<CategoryScreens> {
  final CategoryController _categoryController = CategoryController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String categoryname;
  dynamic _image;
  dynamic _bannerimage;
  pickimage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _image = result.files.first.bytes;
      });
    } else {
      // المستخدم لغى الاختيار
      return null;
    }
  }

  pickbannerimage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _bannerimage = result.files.first.bytes;
      });
    } else {
      // المستخدم لغى الاختيار
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'categories',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Divider(color: Colors.grey),
            ),
            Row(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child:
                      _image != null
                          ? Image.memory(_image, fit: BoxFit.cover)
                          : Center(child: Text('Category Image')),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 200,
                    child: TextFormField(
                      onChanged: (value) {
                        categoryname = value;
                      },
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        } else {
                          return 'please enter your category name';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter Category Name',
                      ),
                    ),
                  ),
                ),
                TextButton(onPressed: () {}, child: Text('Cancel')),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (_image == null || _bannerimage == null) {
                        showSnackBar(
                          context,
                          'الرجاء اختيار صورة القسم والبنر',
                        );
                        return;
                      }

                      await _categoryController.uploadCategory(
                        context: context,
                        name: categoryname,
                        pickimage: _image,
                        pickbanner: _bannerimage,
                      );
                    }
                  },
                  child: Text('Save', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  pickimage();
                },
                child: Text(
                  'Pick Image',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Divider(color: Colors.grey),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
              ),
              child:
                  _bannerimage != null
                      ? Image.memory(_bannerimage, fit: BoxFit.cover)
                      : Center(
                        child: Text(
                          'Category Banner',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  pickbannerimage();
                },
                child: Text('pick Image'),
              ),
            ),
            Divider(color: Colors.grey),
            CategoryWidget(),
          ],
        ),
      ),
    );
  }
}
