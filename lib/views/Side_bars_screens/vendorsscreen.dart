import 'package:flutter/material.dart';
import 'package:flutter_web_multivendor_revrbod/controller/vendor_controller.dart';
import 'package:flutter_web_multivendor_revrbod/model/vendor.dart';

class Vendorsscreen extends StatefulWidget {
  static const String id = '/vendorscreens';

  @override
  State<Vendorsscreen> createState() => _VendorsscreenState();
}

class _VendorsscreenState extends State<Vendorsscreen> {
  late Future<List<Vendor>> _vendorsFuture;
  final VendorService _vendorService = VendorService();

  @override
  void initState() {
    super.initState();
    _vendorsFuture = _vendorService.getAllVendors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Vendors')),
      body: FutureBuilder<List<Vendor>>(
        future: _vendorsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final vendors = snapshot.data ?? [];

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
                  vendors.map((vendor) {
                    return DataRow(
                      cells: [
                        DataCell(
                          vendor.image != null
                              ? Image.network(
                                vendor.image!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              )
                              : Icon(Icons.person, size: 40),
                        ),
                        DataCell(Text(vendor.fullname)),
                        DataCell(Text(vendor.email)),
                        DataCell(
                          Text(
                            '${vendor.state}, ${vendor.city}, ${vendor.locality}',
                          ),
                        ),
                        DataCell(
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              print("Delete ${vendor.fullname}");
                            },
                          ),
                        ),
                      ],
                    );
                  }).toList(),
            ),
          );
        },
      ),
    );
  }
}
