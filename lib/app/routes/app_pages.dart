import 'package:get/get.dart';

import '../data/middlewares/authHomeMiddleware.dart';
import '../modules/Boarding/bindings/boarding_binding.dart';
import '../modules/Boarding/views/boarding_view.dart';
import '../modules/Register/bindings/register_binding.dart';
import '../modules/Register/views/register_view.dart';
import '../modules/RuangObrolan/bindings/ruang_obrolan_binding.dart';
import '../modules/RuangObrolan/views/ruang_obrolan_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.leftToRight,
      middlewares: [
        AuthHomeMiddlewares(priority: 1),
      ],
    ),
    GetPage(
        name: _Paths.RUANG_OBROLAN,
        page: () => const RuangObrolanView(),
        binding: RuangObrolanBinding(),
        transition: Transition.rightToLeft),
    GetPage(
      name: _Paths.BOARDING,
      page: () => const BoardingView(),
      binding: BoardingBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
  ];
}
