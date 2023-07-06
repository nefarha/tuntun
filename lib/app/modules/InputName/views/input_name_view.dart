import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tun_tun/app/data/reusable.dart';

import '../controllers/input_name_controller.dart';

class InputNameView extends GetView<InputNameController> {
  const InputNameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final nameForm = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Masukkan nama'),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Reusable.backgroundGradient(Get.width, Get.height),
          Center(
            child: Form(
              key: nameForm,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Masukkan nama anda",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Reusable.customTextfield(
                      hintText: "masukkan nama anda",
                      controller: controller.nameController,
                      inputType: TextInputType.text,
                      validator: (value) => controller.nameValidator(value!),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 6,
                      backgroundColor: Reusable.actionColor,
                    ),
                    onPressed: () async {
                      if (nameForm.currentState!.validate()) {
                        controller.authC
                            .updateName(nama: controller.nameController.text);
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
