import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tun_tun/app/data/models/chatRoomModel.dart';
import 'package:tun_tun/app/data/reusable.dart';
import 'package:tun_tun/app/modules/home/controllers/home_controller.dart';
import 'package:tun_tun/app/routes/app_pages.dart';

class HomeItem extends GetView<HomeController> {
  const HomeItem({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => ListView(
        children: state!
            .map(
              (ruangObrolan) => Semantics(
                label: "Obrolan dengan",
                child: ListTile(
                  onTap: () async {
                    if (ruangObrolan.lastSender!["sender"] !=
                        controller.userC.user.value!.id) {
                      ChatRoom roomModel =
                          ruangObrolan.copyWith(newMessage: false);
                      controller.dataC.updateRoom(roomModel: roomModel);
                    }
                    Get.toNamed(
                      Routes.RUANG_OBROLAN,
                      arguments: [
                        ruangObrolan,
                        ruangObrolan.tunarungu.id ==
                                controller.userC.user.value!.id
                            ? ruangObrolan.tunatera
                            : ruangObrolan.tunarungu
                      ],
                    );
                  },
                  leading: CircleAvatar(
                    radius: 40,
                    child: Icon(
                      Icons.mail,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  title: Semantics(
                    child: Text(
                      ruangObrolan.tunarungu.id ==
                              controller.userC.user.value!.id
                          ? ruangObrolan.tunatera.name
                          : ruangObrolan.tunarungu.name,
                    ),
                  ),
                  subtitle: Semantics(
                      excludeSemantics: true,
                      child: Text(ruangObrolan.lastSender!['text'])),
                  trailing: (ruangObrolan.newMessage)
                      ? (ruangObrolan.lastSender!['sender'] ==
                              controller.userC.user.value!.id)
                          ? SizedBox()
                          : CircleAvatar(
                              radius: 8,
                              backgroundColor: Reusable.actionColor,
                            )
                      : SizedBox(),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
