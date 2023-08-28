import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tun_tun/app/data/models/chatModel.dart';
import 'package:tun_tun/app/data/models/chatRoomModel.dart';
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
              child: (controller.userC.user.value!.status == 'TUNARUNGU')
                  // UNTUK TUNARUNGU, MUNCULKAN TEXTFIELD
                  ? Card(
                      color: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: TextField(
                          controller: controller.chatTextController,
                          decoration: InputDecoration(
                            hintText: "masukkan pesan disini",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    )
                  // UNTUK TUNANETRA, MUNCULKAN MIC BUTTON
                  : Semantics(
                      label:
                          "Tombol untuk rekam suara dan ubah menjadi teks, tekan dua kali untuk mengaktifkan",
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 6),
                        onPressed: () {
                          controller.listenSound();
                        },
                        child: Semantics(
                          hidden: true,
                          child: Obx(
                            () => Semantics(
                              hidden: true,
                              child: Icon(
                                !controller.isEnabled.value
                                    ? Icons.mic
                                    : Icons.stop,
                              ),
                            ),
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
                onTap: () async {
                  if (controller.userC.user.value!.status == "TUNARUNGU") {
                    if (controller.chatTextController.text.isNotEmpty) {
                      // Buat chat room model baru untuk update
                      ChatRoom newRoomModel =
                          controller.roomModel.value.copyWith(
                        lastSender: {
                          "sender": controller.userC.user.value!.id,
                          "text": controller.chatTextController.text,
                        },
                        newMessage: true,
                      );

                      // Buat chat model untuk dimasukkan ke database
                      ChatModel chatModel = ChatModel(
                        text: controller.chatTextController.text,
                        sender_account: controller.userC.user.value!,
                        recevier_account: controller.receiver,
                        send_at: DateTime.now(),
                        isRead: false,
                      );

                      // Upload chat ke database
                      controller.postChat(
                          chatModel: chatModel, room: newRoomModel);

                      // Update room di database
                      if (await controller.dataC
                          .checkRoomExist(id: newRoomModel.id)) {
                        controller.dataC.updateRoom(roomModel: newRoomModel);
                      }

                      // Push notification ke target device
                      controller.fcmProvider.sendChat(
                          title: controller.userC.user.value!.name,
                          body: controller.chatTextController.text,
                          fcmToken: controller.receiver.token);

                      // Membersihkan isi textfield
                      controller.chatTextController.clear();
                      FocusScope.of(context).unfocus();
                    }
                  } else {
                    if (controller.recognizedText.value.isNotEmpty) {
                      ChatRoom newRoomModel =
                          controller.roomModel.value.copyWith(
                        lastSender: {
                          "sender": controller.userC.user.value!.id,
                          "text": controller.recognizedText.value,
                        },
                        newMessage: true,
                      );

                      // Buat chat model untuk dimasukkan ke database
                      ChatModel chatModel = ChatModel(
                        text: controller.recognizedText.value,
                        sender_account: controller.userC.user.value!,
                        recevier_account: controller.receiver,
                        send_at: DateTime.now(),
                        isRead: false,
                      );

                      // Upload chat ke database
                      controller.postChat(
                          chatModel: chatModel, room: newRoomModel);

                      // Update room di database
                      if (await controller.dataC
                          .checkRoomExist(id: newRoomModel.id)) {
                        controller.dataC.updateRoom(roomModel: newRoomModel);
                      }

                      // Push notification ke target device
                      controller.fcmProvider.sendChat(
                          title: controller.userC.user.value!.name,
                          body: controller.recognizedText.value,
                          fcmToken: controller.receiver.token);
                    }
                  }
                },
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Semantics(
                    label: "Tombol untuk Kirim pesan yang sudah direkam",
                    child: Icon(
                      Icons.send,
                      color: Reusable.textColor,
                    ),
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
