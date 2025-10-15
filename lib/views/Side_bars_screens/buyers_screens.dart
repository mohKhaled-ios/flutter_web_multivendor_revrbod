import 'package:flutter/material.dart';
import 'package:flutter_web_multivendor_revrbod/controller/buyercontroller.dart';
import 'package:flutter_web_multivendor_revrbod/model/user.dart';

class BuyersScreens extends StatefulWidget {
  static const String id = '/ubloadscreens';

  @override
  _BuyersScreensState createState() => _BuyersScreensState();
}

class _BuyersScreensState extends State<BuyersScreens> {
  final UserService userService = UserService();
  late Future<List<UserModel>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = userService.fetchAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Buyers')),
      body: FutureBuilder<List<UserModel>>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No buyers found.'));
          } else {
            final data = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Image')),
                  DataColumn(label: Text('Full Name')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Address')),
                  DataColumn(label: Text('Delete')),
                ],
                rows:
                    data.map((user) {
                      return DataRow(
                        cells: [
                          DataCell(
                            user.image != null
                                ? Image.network(
                                  user.image!,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                )
                                : Icon(Icons.person, size: 40),
                          ),
                          DataCell(Text(user.fullname)),
                          DataCell(Text(user.email)),
                          DataCell(
                            Text(
                              "${user.state}, ${user.city}, ${user.locality}",
                            ),
                          ),
                          DataCell(
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                // TODO: API حذف المستخدم
                                print("Delete ${user.fullname}");
                              },
                            ),
                          ),
                        ],
                      );
                    }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
