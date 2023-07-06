import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tun_tun/app/controllers/auth_controller.dart';

class RegisterController extends GetxController {
  final authC = AuthController.instance;
  String selectedStatus = Get.arguments;

  final phoneNumberController = TextEditingController();

  String? phoneNumberValidatior(String value) {
    if (value.isEmpty ||
        !(RegExp("^(\\+62|62|0)8[1-9][0-9]{6,9}\$").hasMatch(value))) {
      return "mohon perhatikan input";
    } else {
      return null;
    }
  }
}
