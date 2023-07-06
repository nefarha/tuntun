import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tun_tun/app/data/reusable.dart';
import 'package:tun_tun/app/modules/Boarding/controllers/boarding_controller.dart';
import 'package:tun_tun/app/routes/app_pages.dart';

class BlindBoarding extends GetView<BoardingController> {
  const BlindBoarding({super.key});

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
                  text: " Tunanetra?",
                  style: TextStyle(color: Reusable.textColor),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Image(
          height: 180,
          image: AssetImage("assets/icon/blind.png"),
        ),
        SizedBox(
          height: 50,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 6,
            backgroundColor: Reusable.actionColor,
          ),
          onPressed: () {
            Get.toNamed(Routes.REGISTER, arguments: "TUNANETRA");
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
            controller.pageController.previousPage(
                duration: Duration(milliseconds: 500), curve: Curves.linear);
          },
          child: Text("anda seorang tunarungu?"),
        )
      ],
    );
  }
}
