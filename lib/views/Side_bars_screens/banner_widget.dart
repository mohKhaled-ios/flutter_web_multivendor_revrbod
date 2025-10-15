import 'package:flutter/material.dart';
import 'package:flutter_web_multivendor_revrbod/controller/banner_controller.dart';
import 'package:flutter_web_multivendor_revrbod/model/banner.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late Future<List<BannerModel>> futurebanner;
  @override
  void initState() {
    super.initState();
    futurebanner = BannerController().fetchBanners(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futurebanner,
      builder: (context, snapshote) {
        if (snapshote.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(color: Colors.blue);
        } else if (snapshote.hasError) {
          return Text("Error: ${snapshote.error}");
        } else if (snapshote.data!.isEmpty || !snapshote.hasData) {
          return Text("No Banner");
        } else {
          final banners = snapshote.data;
          return GridView.builder(
            shrinkWrap: true,
            itemCount: banners!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,

              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, i) {
              String baseUrl = 'http://192.168.1.3:5000';
              return Image.network(
                width: 100,
                height: 100,
                '$baseUrl${banners[i].image}',
                fit: BoxFit.cover,
              );
            },
          );
        }
      },
    );
  }
}
