import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tun_tun/app/data/reusable.dart';
import 'package:tun_tun/app/modules/home/controllers/home_controller.dart';
import 'package:tun_tun/app/routes/app_pages.dart';

class HomeItem extends GetView<HomeController> {
  const HomeItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          Get.toNamed(Routes.RUANG_OBROLAN);
        },
        leading: CircleAvatar(
          radius: 40,
          child: Icon(
            Icons.person,
            size: 40,
          ),
        ),
        title: Text("Nama User"),
        subtitle: Text("Isi Obrolan"),
      ),
    );
  }
}
