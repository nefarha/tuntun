import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tun_tun/app/data/reusable.dart';
import 'package:tun_tun/app/modules/RuangObrolan/controllers/ruang_obrolan_controller.dart';
import 'package:grouped_list/grouped_list.dart';

class RuangObrolanItem extends GetView<RuangObrolanController> {
  RuangObrolanItem({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: controller.obx(
        (daftarPesan) => GroupedListView(
          useStickyGroupSeparators: true,
          floatingHeader: true,
          itemComparator: (element1, element2) =>
              element1.send_at.millisecondsSinceEpoch -
              element2.send_at.millisecondsSinceEpoch,
          elements: daftarPesan!,
          order: GroupedListOrder.DESC,
          reverse: true,
          groupBy: (pesan) {
            DateTime waktu = DateTime(
              pesan.send_at.year,
              pesan.send_at.month,
              pesan.send_at.day,
            );
            return waktu;
          },
          groupSeparatorBuilder: (value) => Align(
            alignment: Alignment.topCenter,
            child: Card(
              child: Semantics(
                hidden: true,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(8),
                  child: Text(
                    DateFormat(DateFormat.YEAR_MONTH_WEEKDAY_DAY).format(value),
                  ),
                ),
              ),
            ),
          ),
          itemBuilder: (context, pesan) => Align(
            alignment:
                pesan.sender_account.id != controller.userC.user.value!.id
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                    color: pesan.sender_account.id !=
                            controller.userC.user.value!.id
                        ? Reusable.surfaceColor
                        : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: pesan.sender_account.id ==
                              controller.userC.user.value!.id
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
                          pesan.sender_account.id !=
                                  controller.userC.user.value!.id
                              ? Text(
                                  pesan.sender_account.name,
                                  style: TextStyle(
                                    color: pesan.sender_account.id !=
                                            controller.userC.user.value!.id
                                        ? Reusable.textColor
                                        : Reusable.textColor,
                                  ),
                                )
                              : SizedBox(),
                          Text(
                            pesan.text,
                            style: TextStyle(
                              color: pesan.sender_account.id ==
                                      controller.userC.user.value!.id
                                  ? Reusable.textColor
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
