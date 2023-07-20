import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tun_tun/app/data/reusable.dart';
import 'package:tun_tun/app/modules/RuangObrolan/views/ruang_obrolan_item.dart';
import 'package:tun_tun/app/modules/RuangObrolan/views/ruang_obrolan_text.dart';

import '../controllers/ruang_obrolan_controller.dart';

class RuangObrolanView extends GetView<RuangObrolanController> {
  const RuangObrolanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Reusable.customAppbar(
        title: controller.receiver.name,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Semantics(
            label: "Kembali ke halaman sebelumnya",
            child: Icon(Icons.arrow_back),
          ),
        ),
      ),
      body: Stack(
        children: [
          Reusable.backgroundGradient(Get.width, Get.height),
          Column(
            children: [
              Expanded(
                child: RuangObrolanItem(),
              ),
              ChatField(),
            ],
          ),
        ],
      ),
    );
  }
}
