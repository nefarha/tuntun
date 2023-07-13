import 'package:get/get.dart';
import 'package:tun_tun/app/controllers/auth_controller.dart';
import 'package:tun_tun/app/controllers/database_controller.dart';
import 'package:tun_tun/app/data/models/userModel.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final dataC = DatabaseController.instance;
  final authC = AuthController.instance;

  Rxn<UserModel> user = Rxn();

  @override
  void onInit() {
    user.bindStream(dataC.readUser(id: authC.currentUser.value!.uid));
    super.onInit();
  }
}
