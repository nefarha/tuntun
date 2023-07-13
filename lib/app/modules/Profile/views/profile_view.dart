import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tun_tun/app/data/reusable.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Reusable.customAppbar(title: "Profil"),
      body: Column(
        children: [
          ...controller.userMap.entries.map(
            (e) => ListTile(
              title: Text(
                e.value,
              ),
              subtitle: Text(e.key),
            ),
          ),
          ListTile(
            onTap: () {
              controller.authC.logout();
            },
            title: Text(
              "Log out",
            ),
          ),
        ],
      ),
    );
  }
}
