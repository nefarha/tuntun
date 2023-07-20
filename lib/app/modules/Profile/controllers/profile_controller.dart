import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tun_tun/app/controllers/auth_controller.dart';
import 'package:tun_tun/app/controllers/database_controller.dart';
import 'package:tun_tun/app/controllers/user_controller.dart';
import 'package:tun_tun/app/data/reusable.dart';

class ProfileController extends GetxController {
  final userC = UserController.instance;
  final authC = AuthController.instance;
  final dataC = DatabaseController.instance;

  Map<String, dynamic> get userMap =>
      {"phone": userC.user.value!.phone, "status": userC.user.value!.status};

  void changeName(TextEditingController namaController) async {
    await authC.changeName(nama: namaController.text);
    await dataC.updateName(id: userC.user.value!.id, name: namaController.text);
    await dataC.changeAllRoomData(
        userModel: userC.user.value!, name: namaController.text);
  }

  Future logOut() async {
    await dataC.updateTokenUser(id: authC.currentUser.value!.uid, token: "");
    await authC.logout();
  }
}
