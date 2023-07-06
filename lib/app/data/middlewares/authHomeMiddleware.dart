import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tun_tun/app/routes/app_pages.dart';

class AuthHomeMiddlewares extends GetMiddleware {
  bool isAuth = false;
  @override
  int? priority = 0;

  AuthHomeMiddlewares({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    // TODO: implement redirect
    if (isAuth == false) {
      return RouteSettings(name: Routes.BOARDING);
    }
  }
}
