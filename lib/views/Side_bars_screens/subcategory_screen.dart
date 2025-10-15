import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_multivendor_revrbod/controller/category_controller.dart';
import 'package:flutter_web_multivendor_revrbod/controller/subcategory_controller.dart';
import 'package:flutter_web_multivendor_revrbod/model/category.dart';
import 'package:flutter_web_multivendor_revrbod/widget/subcategory_widget.dart';

class SubcategoryScreen extends StatefulWidget {
  static const String id = '/subcategoryscreen';
  const SubcategoryScreen({super.key});

  @override
  State<SubcategoryScreen> createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Future<List<CategoryModel>> futurecategory;
  CategoryModel? _selectedcategory;
  dynamic _image;
  late String name;

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

  @override
  void initState() {
    futurecategory = CategoryController().fetchAllCategories(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'subcategories',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Divider(color: Colors.grey),
            ),
            FutureBuilder(
              future: futurecategory,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No Category'));
                } else {
                  return DropdownButton<CategoryModel>(
                    value: _selectedcategory,
                    hint: Text('Select Category'),
                    items:
                        snapshot.data!.map((CategoryModel category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(category.name),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedcategory = value;
                      });
                      print(_selectedcategory!.name);
                    },
                  );
                }
              },
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
                          : Center(child: Text('Subcategory Image')),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 200,
                    child: TextFormField(
                      onChanged: (value) {
                        name = value;
                      },
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        } else {
                          return 'please enter your subcategory name';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter Subcategory Name',
                      ),
                    ),
                  ),
                ),
                TextButton(onPressed: () {}, child: Text('Cancel')),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      SubCategoryController().createSubCategory(
                        categoryId: _selectedcategory!.id,
                        categoryName: _selectedcategory!.name,
                        subcategoryName: name,
                        imageFile: _image,
                        context: context,
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
                onPressed: () {
                  pickimage();
                },
                child: Text('pick Image'),
              ),
            ),
            Divider(color: Colors.grey),
            SubcategoryWidget(),
          ],
        ),
      ),
    );
  }
}
