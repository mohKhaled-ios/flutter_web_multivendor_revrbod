import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_web_multivendor_revrbod/views/Side_bars_screens/buyers_screens.dart';
import 'package:flutter_web_multivendor_revrbod/views/Side_bars_screens/category_screens.dart';
import 'package:flutter_web_multivendor_revrbod/views/Side_bars_screens/order_screens.dart';
import 'package:flutter_web_multivendor_revrbod/views/Side_bars_screens/product_screens.dart';
import 'package:flutter_web_multivendor_revrbod/views/Side_bars_screens/subcategory_screen.dart';
import 'package:flutter_web_multivendor_revrbod/views/Side_bars_screens/ubload_banners.dart';
import 'package:flutter_web_multivendor_revrbod/views/Side_bars_screens/vendorsscreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedscreen = Vendorsscreen();
  screenselector(item) {
    switch (item.route) {
      case BuyersScreens.id:
        setState(() {
          _selectedscreen = BuyersScreens();
        });

        break;
      case Vendorsscreen.id:
        setState(() {
          _selectedscreen = Vendorsscreen();
        });

        break;
      case OrderScreens.id:
        setState(() {
          _selectedscreen = OrderScreens();
        });

        break;
      case CategoryScreens.id:
        setState(() {
          _selectedscreen = CategoryScreens();
        });

        break;
      case SubcategoryScreen.id:
        setState(() {
          _selectedscreen = SubcategoryScreen();
        });

        break;
      case ProductScreens.id:
        setState(() {
          _selectedscreen = ProductScreens();
        });

        break;

      case UploadBanners.id:
        setState(() {
          _selectedscreen = UploadBanners();
        });

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(backgroundColor: Colors.blue, title: Text('Managment')),
      body: _selectedscreen,
      sideBar: SideBar(
        header: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.black),
          child: Center(
            child: Text(
              'Multi Vendors Admin',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.7,
                color: Colors.white,
              ),
            ),
          ),
        ),
        items: [
          AdminMenuItem(
            title: 'Vendors',
            route: Vendorsscreen.id,
            icon: CupertinoIcons.person,
          ),
          AdminMenuItem(
            title: 'Bury',
            route: BuyersScreens.id,
            icon: CupertinoIcons.person_3,
          ),
          AdminMenuItem(
            title: 'Orders',
            route: OrderScreens.id,
            icon: CupertinoIcons.shopping_cart,
          ),
          AdminMenuItem(
            title: 'Categorys',
            route: CategoryScreens.id,
            icon: CupertinoIcons.collections,
          ),
          AdminMenuItem(
            title: 'Ubload Banners',
            route: UploadBanners.id,
            icon: CupertinoIcons.upload_circle,
          ),
          AdminMenuItem(
            title: 'Subcategory',
            route: SubcategoryScreen.id,
            icon: Icons.category_outlined,
          ),

          AdminMenuItem(
            title: 'Productes',
            route: ProductScreens.id,
            icon: Icons.store,
          ),
        ],
        selectedRoute: Vendorsscreen.id,
        onSelected: (item) {
          screenselector(item);
        },
      ),
    );
  }
}
