import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tun_tun/app/controllers/auth_controller.dart';
import 'package:tun_tun/app/controllers/database_controller.dart';

class InputNameController extends GetxController {
  final authC = AuthController.instance;
  final dataC = DatabaseController.instance;

  final nameController = TextEditingController();

  RxnString deviceToken = RxnString();

  String? nameValidator(String value) {
    if (value.isEmpty) {
      return "tolong masukkan nama anda";
    } else {
      return null;
    }
  }

  @override
  void onInit() async {
    deviceToken.value = await FirebaseMessaging.instance.getToken();
    super.onInit();
  }
}
