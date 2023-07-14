import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tun_tun/app/controllers/database_controller.dart';
import 'package:tun_tun/app/controllers/user_controller.dart';
import 'package:tun_tun/app/data/models/chatModel.dart';
import 'package:tun_tun/app/data/models/chatRoomModel.dart';
import 'package:tun_tun/app/data/models/userModel.dart';

class RuangObrolanController extends GetxController
    with StateMixin<List<ChatModel>> {
  final userC = UserController.instance;
  final dataC = DatabaseController.instance;

  ChatRoom roomModel = Get.arguments[0];
  UserModel receiver = Get.arguments[1];

  final chatTextController = TextEditingController();

  RxList<ChatModel> daftarChat = RxList.empty();

  Future postChat({required ChatModel chatModel}) async {
    var isRoomExist = await dataC.checkRoomExist(id: roomModel.id);

    if (isRoomExist) {
      dataC.addChat(roomModel: roomModel, chatModel: chatModel);
    } else {
      dataC.createChatroom(model: roomModel).then(
          (value) => dataC.addChat(roomModel: roomModel, chatModel: chatModel));
    }
  }

  @override
  void onInit() {
    daftarChat
        .bindStream(dataC.readChat(roomModel: roomModel).asyncMap((event) {
      change(event, status: RxStatus.success());
      return event;
    }));
    super.onInit();
  }
}
