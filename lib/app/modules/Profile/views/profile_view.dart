import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tun_tun/app/data/dialogModel.dart';
import 'package:tun_tun/app/data/reusable.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Reusable.customAppbar(
        title: "Profil",
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Semantics(
            label: "Kembali ke halaman sebelumnya",
            child: Icon(Icons.arrow_back),
          ),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () {
              TextEditingController namaController = TextEditingController();
              Reusable.changeName(
                  onConfirm: () {
                    if (namaController.text.isNotEmpty) {
                      controller.changeName(namaController);
                      Get.back();
                    } else {
                      DialogModel.ErrorDialog(
                          "Harap isi kolom jika ingin ganti nama");
                    }
                  },
                  namaController: namaController);
            },
            title: Obx(
              () => Text(
                controller.userC.user.value!.name,
              ),
            ),
            subtitle: Text(
              "nama",
            ),
          ),
          ...controller.userMap.entries.map(
            (e) => ListTile(
              title: Semantics(
                hidden: true,
                child: Text(
                  e.value,
                ),
              ),
              subtitle: Text(
                e.key,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              controller.logOut();
            },
            title: Semantics(
              readOnly: true,
              child: Text(
                "Keluar akun",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
