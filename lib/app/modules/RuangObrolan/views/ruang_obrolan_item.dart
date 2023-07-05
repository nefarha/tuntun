import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tun_tun/app/data/reusable.dart';
import 'package:tun_tun/app/modules/RuangObrolan/controllers/ruang_obrolan_controller.dart';

class RuangObrolanItem extends GetView<RuangObrolanController> {
  const RuangObrolanItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: ListView.separated(
        reverse: true,
        itemCount: 100,
        separatorBuilder: (context, index) => SizedBox(
          height: 10,
        ),
        itemBuilder: (context, index) {
          return Align(
            alignment:
                index % 2 == 0 ? Alignment.centerLeft : Alignment.centerRight,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 250),
              child: ShaderMask(
                shaderCallback: (bounds) {
                  return LinearGradient(
                    colors: [
                      Reusable.surfaceColor,
                      Reusable.backgroundColor,
                    ],
                  ).createShader(bounds);
                },
                child: Card(
                  color: index % 2 != 0 ? Reusable.surfaceColor : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: index % 2 != 0
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          )
                        : const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                  ),
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pengirim",
                          style: TextStyle(
                            color: index % 2 == 0
                                ? Reusable.textColor
                                : Reusable.textColor,
                          ),
                        ),
                        Text(
                          "Isi Teks " * (index + 1),
                          style: TextStyle(
                            color: index % 2 == 0 ? Colors.grey : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
