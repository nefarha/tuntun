import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tun_tun/app/data/models/userModel.dart';
import 'package:tun_tun/app/data/reusable.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final registerKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Reusable.backgroundGradient(Get.width, Get.height),
          Center(
            child: Form(
              key: registerKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Masukkan nomor HandPhone yang masih berfungsi",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Reusable.customTextfield(
                      hintText: "masukkan nomor telepon",
                      controller: controller.phoneNumberController,
                      inputType: TextInputType.phone,
                      validator: (value) =>
                          controller.phoneNumberValidatior(value!),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 6,
                      backgroundColor: Reusable.actionColor,
                    ),
                    onPressed: () async {
                      if (registerKey.currentState!.validate()) {
                        var number = controller.phoneNumberController.text;
                        if (number[0] == "0") {
                          number = number.replaceFirst(RegExp(r'0'), '+62');
                        }

                        await controller.authC.phoneAuthSignIn(
                            phoneNumber: number,
                            status: controller.selectedStatus,
                            token: controller.deviceToken.value!);
                      }
                    },
                    child: Text(
                      "konfirmasi",
                      style: TextStyle(
                          color: Reusable.textColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
