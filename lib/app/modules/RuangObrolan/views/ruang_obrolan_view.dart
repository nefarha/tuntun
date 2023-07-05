import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ruang_obrolan_controller.dart';

class RuangObrolanView extends GetView<RuangObrolanController> {
  const RuangObrolanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RuangObrolanView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RuangObrolanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
