import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tun_tun/app/controllers/auth_controller.dart';
import 'package:tun_tun/app/controllers/database_controller.dart';

class RegisterController extends GetxController {
  final authC = AuthController.instance;
  final dataC = DatabaseController.instance;
  String selectedStatus = Get.arguments;

  final phoneNumberController = TextEditingController();

  RxnString deviceToken = RxnString();

  String? phoneNumberValidatior(String value) {
    if (value.isEmpty ||
        !(RegExp("^(\\+62|62|0)8[1-9][0-9]{6,9}\$").hasMatch(value))) {
      return "mohon perhatikan input";
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
