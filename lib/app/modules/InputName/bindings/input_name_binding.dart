import 'package:get/get.dart';

import '../controllers/input_name_controller.dart';

class InputNameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InputNameController>(
      () => InputNameController(),
    );
  }
}
