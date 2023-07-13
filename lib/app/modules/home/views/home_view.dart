import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tun_tun/app/data/reusable.dart';
import 'package:tun_tun/app/modules/home/views/home_item.dart';
import 'package:tun_tun/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Reusable.customAppbar(
        leading: IconButton(
          onPressed: () {
            Get.toNamed(Routes.PROFILE);
          },
          icon: Icon(Icons.person),
        ),
        title: "Obrolan",
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: controller.customSearchDelegate,
              );
            },
            icon: Icon(
              Icons.search,
              color: Reusable.actionColor,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              print(controller.authC.logout());
            },
            icon: Icon(
              Icons.camera_alt_outlined,
              size: 30,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body: HomeItem(),
    );
  }
}
