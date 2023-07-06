import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tun_tun/app/data/reusable.dart';
import 'package:tun_tun/app/modules/Boarding/views/boarding_blind.dart';
import 'package:tun_tun/app/modules/Boarding/views/boarding_deaf.dart';

import '../controllers/boarding_controller.dart';

class BoardingView extends GetView<BoardingController> {
  const BoardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Reusable.backgroundGradient(Get.width, Get.height),
          PageView(
            controller: controller.pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [DeafBoarding(), BlindBoarding()],
          ),
        ],
      ),
    );
  }
}
