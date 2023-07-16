import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tun_tun/app/data/reusable.dart';
import 'package:tun_tun/app/modules/Boarding/controllers/boarding_controller.dart';
import 'package:tun_tun/app/routes/app_pages.dart';

class DeafBoarding extends GetView<BoardingController> {
  const DeafBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: GoogleFonts.kanit(color: Colors.black, fontSize: 35),
              children: [
                TextSpan(text: "Anda"),
                TextSpan(text: " Seorang"),
                TextSpan(
                  text: " Tunarungu?",
                  style: TextStyle(color: Reusable.textColor),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 80,
        ),
        Semantics(
          excludeSemantics: true,
          child: Image(
            height: 100,
            image: AssetImage("assets/icon/deaf.png"),
          ),
        ),
        SizedBox(
          height: 80,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 6,
            backgroundColor: Reusable.actionColor,
          ),
          onPressed: () {
            Get.toNamed(Routes.REGISTER, arguments: "TUNARUNGU");
          },
          child: Text(
            "Masuk disini",
            style: TextStyle(color: Reusable.textColor),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextButton(
          onPressed: () {
            controller.pageController.nextPage(
                duration: Duration(milliseconds: 500), curve: Curves.linear);
          },
          child: Text("anda seorang tunanetra?"),
        )
      ],
    );
  }
}
