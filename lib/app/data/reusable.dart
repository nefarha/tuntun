import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Reusable {
  static var backgroundColor = const Color(0xffdbebff);
  static var surfaceColor = Color.fromARGB(255, 194, 208, 226);
  static var textColor = const Color(0xff1f4b7d);
  static var actionColor = const Color(0xfff4c34f);
  static var gradientIner = Color.fromARGB(255, 154, 164, 175);
  static var gradientOuter = Color.fromARGB(255, 169, 182, 196);

  static AppBar customAppbar(
      {String title = '', List<Widget>? actions, double height = 80}) {
    return AppBar(
      toolbarHeight: height,
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
      ),
      actions: actions,
    );
  }

  static Widget backgroundGradient(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            backgroundColor,
            surfaceColor,
          ],
        ),
      ),
    );
  }
}
