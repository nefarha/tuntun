import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tun_tun/app/controllers/auth_controller.dart';
import 'package:tun_tun/app/controllers/user_controller.dart';
import 'package:tun_tun/app/routes/app_pages.dart';

class AuthHomeMiddlewares extends GetMiddleware {
  final authC = AuthController.instance;
  @override
  int? priority = 0;

  AuthHomeMiddlewares({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    if (authC.currentUser.value == null) {
      return RouteSettings(name: Routes.BOARDING);
    }
    if (authC.currentUser.value!.displayName == null ||
        authC.currentUser.value!.displayName!.isEmpty) {
      return RouteSettings(name: Routes.INPUT_NAME);
    }
  }

  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    Get.put(UserController());
    return super.onBindingsStart(bindings);
  }
}
