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
        leading: Semantics(
          label: "Tombol Informasi Akun",
          child: IconButton(
            onPressed: () {
              Get.toNamed(Routes.PROFILE);
            },
            icon: Semantics(
              hidden: true,
              excludeSemantics: true,
              child: Icon(Icons.person),
            ),
          ),
        ),
        title: "Obrolan",
        actions: [
          Semantics(
            label: "Tombol pencarian, untuk mencari pengguna lain",
            child: IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  
                  delegate:
                      CustomSearch(daftarPencarian: controller.daftarPencarian),
                );
              },
              icon: Semantics(
                hidden: true,
                child: Icon(
                  Icons.search,
                  color: Reusable.actionColor,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
      body: HomeItem(),
    );
  }
}
