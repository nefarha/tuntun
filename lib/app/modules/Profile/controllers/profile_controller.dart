import 'package:get/get.dart';
import 'package:tun_tun/app/controllers/auth_controller.dart';
import 'package:tun_tun/app/controllers/user_controller.dart';

class ProfileController extends GetxController {
  final userC = UserController.instance;
  final authC = AuthController.instance;

  Map<String, dynamic> get userMap => {
        "nama": userC.user.value!.name,
        "phone": userC.user.value!.phone,
        "status": userC.user.value!.status,
      };
}
