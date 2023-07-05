import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tun_tun/app/modules/home/controllers/home_controller.dart';
import 'package:tun_tun/app/routes/app_pages.dart';

class HomeItem extends GetView<HomeController> {
  const HomeItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.85,
      width: Get.width,
      padding: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
        ),
      ),
      child: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            Get.toNamed(Routes.RUANG_OBROLAN);
          },
          leading: CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text("Nama User"),
          subtitle: Text("Isi Obrolan"),
        ),
      ),
    );
  }
}
