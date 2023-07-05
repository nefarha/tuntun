import 'package:get/get.dart';

import '../controllers/ruang_obrolan_controller.dart';

class RuangObrolanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RuangObrolanController>(
      () => RuangObrolanController(),
    );
  }
}
