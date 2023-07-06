import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tun_tun/app/controllers/auth_controller.dart';
import 'package:tun_tun/app/routes/app_pages.dart';

class InputNameMiddleware extends GetMiddleware {
  final auhtC = AuthController.instance;
  @override
  int? priority = 0;

  InputNameMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    // TODO: implement redirect
    if (auhtC.currentUser.value!.displayName == null) {
      return RouteSettings(name: Routes.INPUT_NAME);
    }
  }
}
