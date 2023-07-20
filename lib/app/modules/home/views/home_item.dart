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
      (state) => ListView.separated(
        separatorBuilder: (context, index) => Divider(
          thickness: 1,
          color: Reusable.textColor,
        ),
        itemCount: state!.length,
        itemBuilder: (context, index) {
          ChatRoom ruangObrolan = state[index];
          return Semantics(
            label: "Obrolan dengan",
            child: ListTile(
              onTap: () async {
                if (ruangObrolan.lastSender != null) {
                  if (ruangObrolan.lastSender!["sender"] !=
                      controller.userC.user.value!.id) {
                    ChatRoom roomModel =
                        ruangObrolan.copyWith(newMessage: false);
                    controller.dataC.updateRoom(roomModel: roomModel);
                  }
                }
                Get.toNamed(
                  Routes.RUANG_OBROLAN,
                  arguments: [
                    ruangObrolan,
                    ruangObrolan.tunarungu.id == controller.userC.user.value!.id
                        ? ruangObrolan.tunatera
                        : ruangObrolan.tunarungu
                  ],
                );
              },
              trailing: (ruangObrolan.lastSender != null)
                  ? (ruangObrolan.lastSender!['sender'] !=
                              controller.userC.user.value!.id &&
                          ruangObrolan.newMessage == true)
                      ? CircleAvatar(
                          backgroundColor: Reusable.actionColor,
                          radius: 10,
                        )
                      : SizedBox()
                  : SizedBox(),
              leading: CircleAvatar(
                backgroundColor: Reusable.textColor,
                radius: 40,
                child: Icon(
                  Icons.mail,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              title: Semantics(
                child: Text(
                  ruangObrolan.tunarungu.id == controller.userC.user.value!.id
                      ? ruangObrolan.tunatera.name
                      : ruangObrolan.tunarungu.name,
                ),
              ),
              subtitle: (ruangObrolan.lastSender != null)
                  ? Text(ruangObrolan.lastSender!['text'])
                  : SizedBox(),
            ),
          );
        },
      ),
    );
  }
}
