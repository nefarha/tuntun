import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tun_tun/app/data/reusable.dart';
import 'package:tun_tun/app/modules/RuangObrolan/controllers/ruang_obrolan_controller.dart';

class ChatField extends GetView<RuangObrolanController> {
  const ChatField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Card(
                color: Colors.grey.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "masukkan pesan disini",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: 4,
              child: InkWell(
                onTap: () {},
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Icon(
                    Icons.send,
                    color: Reusable.textColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
