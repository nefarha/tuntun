import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tun_tun/app/modules/home/views/home_item.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Obrolan"),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: controller.customSearchDelegate,
              );
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background Halaman Utama
          Container(
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue,
                  Colors.blue.shade100,
                  Colors.blue.shade100,
                  Colors.blue.shade100,
                  Colors.blue.shade100,
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: HomeItem(),
          )
        ],
      ),
    );
  }
}
