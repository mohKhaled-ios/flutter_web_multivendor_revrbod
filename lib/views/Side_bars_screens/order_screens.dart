// import 'package:flutter/material.dart';
// import 'package:flutter_web_multivendor_revrbod/controller/order_controller.dart';
// import 'package:flutter_web_multivendor_revrbod/model/order.dart';

// class OrderScreens extends StatefulWidget {
//   static const String id = '/ordersscreens';
//   const OrderScreens({super.key});

//   @override
//   State<OrderScreens> createState() => _OrderScreensState();
// }

// class _OrderScreensState extends State<OrderScreens> {
//   late Future<List<OrderModel>> _ordersFuture;
//   final OrderService _orderService = OrderService();

//   @override
//   void initState() {
//     super.initState();
//     _ordersFuture = _orderService.getAllOrders();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("إدارة الطلبات")),
//       body: FutureBuilder<List<OrderModel>>(
//         future: _ordersFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text("حدث خطأ: ${snapshot.error}"));
//           }
//           final orders = snapshot.data ?? [];
//           if (orders.isEmpty) {
//             return Center(child: Text("لا توجد طلبات"));
//           }

//           return SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: DataTable(
//               columns: const [
//                 DataColumn(label: Text("صورة المنتج")),
//                 DataColumn(label: Text("اسم المنتج")),
//                 DataColumn(label: Text("العميل")),
//                 DataColumn(label: Text("الكمية")),
//                 DataColumn(label: Text("السعر")),
//                 DataColumn(label: Text("الحالة")),
//                 DataColumn(label: Text("حذف")),
//               ],
//               rows:
//                   orders.map((order) {
//                     return DataRow(
//                       cells: [
//                         DataCell(
//                           Image.network(
//                             order.productImage,
//                             width: 50,
//                             height: 50,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         DataCell(Text(order.productName)),
//                         DataCell(Text(order.fullName)),
//                         DataCell(Text(order.quantity.toString())),
//                         DataCell(Text("${order.productPrice} ج")),
//                         DataCell(Text(order.status)),
//                         DataCell(
//                           IconButton(
//                             icon: Icon(Icons.delete, color: Colors.red),
//                             onPressed: () async {
//                               await _orderService.deleteOrder(order.id);
//                               setState(() {
//                                 _ordersFuture = _orderService.getAllOrders();
//                               });
//                             },
//                           ),
//                         ),
//                       ],
//                     );
//                   }).toList(),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_multivendor_revrbod/model/order.dart';
import 'package:flutter_web_multivendor_revrbod/controller/order_controller.dart';

class OrderScreens extends StatefulWidget {
  static const String id = '/ordersscreens';
  const OrderScreens({super.key});

  @override
  State<OrderScreens> createState() => _OrderScreensState();
}

class _OrderScreensState extends State<OrderScreens> {
  late Future<List<OrderModel>> _ordersFuture;
  final OrderService _orderService = OrderService();

  @override
  void initState() {
    super.initState();
    _ordersFuture = _orderService.getAllOrders();
  }

  void _refreshOrders() {
    setState(() {
      _ordersFuture = _orderService.getAllOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("إدارة الطلبات")),
      body: FutureBuilder<List<OrderModel>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("حدث خطأ: ${snapshot.error}"));
          }
          final orders = snapshot.data ?? [];
          if (orders.isEmpty) {
            return const Center(child: Text("لا توجد طلبات"));
          }

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                columns: const [
                  DataColumn(label: Text("صورة المنتج")),
                  DataColumn(label: Text("اسم المنتج")),
                  DataColumn(label: Text("العميل")),
                  DataColumn(label: Text("الكمية")),
                  DataColumn(label: Text("السعر")),
                  DataColumn(label: Text("الحالة")),
                  DataColumn(label: Text("حذف")),
                ],
                rows:
                    orders.map((order) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Image.memory(
                              base64Decode(order.productImage),
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),

                            // Image.network(
                            //   "http://192.168.1.3:5000/uploads/${order.productImage}",
                            //   width: 50,
                            //   height: 50,
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                          DataCell(Text(order.productName)),
                          DataCell(Text(order.fullName)),
                          DataCell(Text(order.quantity.toString())),
                          DataCell(Text("${order.productPrice} ج")),
                          DataCell(Text(order.status)),
                          DataCell(
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                await _orderService.deleteOrder(order.id);
                                _refreshOrders();
                              },
                            ),
                          ),
                        ],
                      );
                    }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
