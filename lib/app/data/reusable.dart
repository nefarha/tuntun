import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tun_tun/app/controllers/database_controller.dart';
import 'package:tun_tun/app/data/dialogModel.dart';
import 'package:tun_tun/app/data/models/userModel.dart';
import 'package:tun_tun/app/routes/app_pages.dart';

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
      backgroundColor: surfaceColor,
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
        child: Semantics(
          label: "Kotak Input",
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
      ),
    );
  }

  static Future<String?> askingSMSCode(
      {required String verificationId,
      required FirebaseAuth instance,
      required String status,
      required String token,
      required DatabaseController dataC}) async {
    TextEditingController smscontroller = TextEditingController();
    return await Get.defaultDialog(
      barrierDismissible: false,
      onCancel: () {},
      title: "OTP",
      content: Semantics(
        label: "otepe",
        child: customTextfield(
          controller: smscontroller,
          hintText: 'masukkan kode',
          inputType: TextInputType.number,
        ),
      ),
      onConfirm: () async {
        if (smscontroller.text.isNotEmpty) {
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smscontroller.text);

          try {
            await instance.signInWithCredential(credential).then(
              (value) {
                UserModel model = UserModel(
                    id: value.user!.uid,
                    name: "",
                    status: status,
                    phone: value.user!.phoneNumber!,
                    token: token);

                dataC.createUser(model: model);
              },
            );

            Get.offAllNamed(Routes.HOME);
          } on FirebaseAuthException catch (e) {
            if (e.code == "invalid-verification-code") {
              DialogModel.ErrorDialog("Kode verifikasi salah");
            } else {
              DialogModel.ErrorDialog("Terjadi suatu kesalahan");
            }
          }
        }
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
