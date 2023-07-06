import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tun_tun/app/controllers/auth_controller.dart';

class InputNameController extends GetxController {
  final authC = AuthController.instance;

  final nameController = TextEditingController();

  String? nameValidator(String value) {
    if (value.isEmpty) {
      return "tolong masukkan nama anda";
    } else {
      return null;
    }
  }
}
