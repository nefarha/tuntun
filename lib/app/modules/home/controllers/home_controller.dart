import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tun_tun/app/controllers/auth_controller.dart';
import 'package:tun_tun/app/controllers/database_controller.dart';
import 'package:tun_tun/app/controllers/user_controller.dart';
import 'package:tun_tun/app/data/models/chatRoomModel.dart';
import 'package:tun_tun/app/data/models/userModel.dart';
import 'package:tun_tun/app/routes/app_pages.dart';

class HomeController extends GetxController with StateMixin<List<ChatRoom>> {
  final authC = AuthController.instance;
  final dataC = DatabaseController.instance;
  final userC = UserController.instance;

  late StreamSubscription messageStream;

  RxList<UserModel> daftarPencarian = RxList.empty();
  RxList<ChatRoom> daftarRuangObrolan = RxList.empty();

  @override
  void onInit() {
    daftarPencarian.bindStream(dataC.readAllUser());

    daftarRuangObrolan.bindStream(
        dataC.readRoom(id: authC.currentUser.value!.uid).asyncMap((event) {
      change(event, status: RxStatus.success());

      return event;
    }));

    super.onInit();
  }
}

class CustomSearch extends SearchDelegate {
  List<UserModel> daftarPencarian;
  HomeController homeC = Get.find<HomeController>();

  CustomSearch({required this.daftarPencarian});

  @override
  List<Widget>? buildActions(BuildContext context) {
    // ini untuk tombol yang ada disebelah kanan search
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.search_off),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // ini untuk tombol yang ada di sebelah kiri
    return IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // Ini untuk memunculkan hasil pencarian saat tombol enter ditekan
    List<UserModel> hasilPencarian = [];
    daftarPencarian.forEach(
      (user) {
        if (user.name.toLowerCase().contains(query.toLowerCase()) ||
            user.phone.toLowerCase().contains(query.toLowerCase())) {
          hasilPencarian.add(user);
        }
      },
    );

    return (hasilPencarian.length > 0)
        ? ListView(
            children: hasilPencarian
                .where((element) =>
                    element.status != homeC.userC.user.value!.status)
                .map(
                  (user) => ListTile(
                    onTap: () async {
                      Get.toNamed(
                        Routes.RUANG_OBROLAN,
                        arguments: [
                          ChatRoom(
                            id: (user.status == "TUNANETRA")
                                ? "${homeC.userC.user.value!.id}and${user.id}"
                                : "${user.id}and${homeC.userC.user.value!.id}",
                            tunatera: (user.status == "TUNANETRA")
                                ? user
                                : homeC.userC.user.value!,
                            tunarungu:
                                (homeC.userC.user.value!.status == "TUNARUNGU")
                                    ? homeC.userC.user.value!
                                    : user,
                            newMessage: false,
                          ),
                          user,
                        ],
                      );
                    },
                    title: Text(user.name),
                    subtitle: Text(user.phone),
                  ),
                )
                .toList(),
          )
        : Center(
            child: Text("Data Tidak Ditemukan"),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Ini untuk memunculkan hasil saran pencarian saat kolom teks diisi

    List<UserModel> hasilSaran = [];
    daftarPencarian.forEach(
      (user) {
        if (user.name.toLowerCase().contains(query.toLowerCase()) ||
            user.phone.toLowerCase().contains(query.toLowerCase())) {
          hasilSaran.add(user);
        }
      },
    );

    return (hasilSaran.length > 0)
        ? ListView(
            children: hasilSaran
                .where((element) =>
                    element.status != homeC.userC.user.value!.status)
                .map(
                  (user) => ListTile(
                    onTap: () async {
                      Get.toNamed(
                        Routes.RUANG_OBROLAN,
                        arguments: [
                          ChatRoom(
                              id: (user.status == "TUNANETRA")
                                  ? "${homeC.userC.user.value!.id}and${user.id}"
                                  : "${user.id}and${homeC.userC.user.value!.id}",
                              tunatera: (user.status == "TUNANETRA")
                                  ? user
                                  : homeC.userC.user.value!,
                              tunarungu: (homeC.userC.user.value!.status ==
                                      "TUNARUNGU")
                                  ? homeC.userC.user.value!
                                  : user,
                              newMessage: false),
                          user,
                        ],
                      );
                    },
                    title: Text(user.name),
                    subtitle: Text(user.phone),
                  ),
                )
                .toList(),
          )
        : Center(
            child: Text("Data Tidak Ditemukan"),
          );
  }
}
