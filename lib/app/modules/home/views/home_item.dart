import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tun_tun/app/data/reusable.dart';
import 'package:tun_tun/app/modules/home/controllers/home_controller.dart';
import 'package:tun_tun/app/routes/app_pages.dart';

class HomeItem extends GetView<HomeController> {
  const HomeItem({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => ListView(
        children: state!
            .map(
              (ruangObrolan) => ListTile(
                onTap: () {
                  Get.toNamed(Routes.RUANG_OBROLAN, arguments: [
                    ruangObrolan,
                    ruangObrolan.tunarungu.id == controller.userC.user.value!.id
                        ? ruangObrolan.tunatera
                        : ruangObrolan.tunarungu
                  ]);
                },
                leading: CircleAvatar(
                  radius: 40,
                  child: Icon(
                    Icons.person,
                    size: 40,
                  ),
                ),
                title: Text(
                  ruangObrolan.tunarungu.id == controller.userC.user.value!.id
                      ? ruangObrolan.tunatera.name
                      : ruangObrolan.tunarungu.name,
                ),
                subtitle: Text("Isi Obrolan"),
              ),
            )
            .toList(),
      ),
    );
  }
}
