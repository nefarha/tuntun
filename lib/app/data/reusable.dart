import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Reusable {
  static var backgroundColor = const Color(0xffdbebff);
  static var surfaceColor = Color.fromARGB(255, 194, 208, 226);
  static var textColor = const Color(0xff1f4b7d);
  static var actionColor = Color.fromARGB(255, 211, 169, 70);
  static var gradientIner = Color.fromARGB(255, 154, 164, 175);
  static var gradientOuter = Color.fromARGB(255, 169, 182, 196);

  static AppBar customAppbar(
      {String title = '',
      List<Widget>? actions,
      double height = 80,
      Widget? leading}) {
    return AppBar(
      leading: leading,
      toolbarHeight: height,
      elevation: 0,
      title: Semantics(
        hidden: true,
        excludeSemantics: true,
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        ),
      ),
      actions: actions,
    );
  }

  static Widget backgroundGradient(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            backgroundColor,
            surfaceColor,
          ],
        ),
      ),
    );
  }

  static Widget customTextfield(
      {required String hintText,
      required TextEditingController controller,
      required TextInputType inputType,
      String? Function(String? value)? validator}) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          validator: validator,
          controller: controller,
          keyboardType: inputType,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
          ),
        ),
      ),
    );
  }

  static Future<String?> askingSMSCode() async {
    TextEditingController smscontroller = TextEditingController();
    return await Get.defaultDialog(
      barrierDismissible: false,
      title: "OTP",
      content: customTextfield(
        controller: smscontroller,
        hintText: 'enter otp',
        inputType: TextInputType.number,
      ),
      onConfirm: () {
        Get.back(result: smscontroller.text);
      },
    );
  }

  static changeName(
      {required Function()? onConfirm,
      required TextEditingController namaController}) async {
    await Get.defaultDialog(
      title: "Ubah Nama",
      content: customTextfield(
        controller: namaController,
        hintText: 'masukkan nama',
        inputType: TextInputType.text,
      ),
      onConfirm: onConfirm,
    );
  }
}
