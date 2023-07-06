import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogModel {
  static ErrorDialog(String e) {
    return Get.defaultDialog(
      title: "Error",
      middleText: e,
      onCancel: () {},
    );
  }
}
