import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:tun_tun/app/controllers/database_controller.dart';
import 'package:tun_tun/app/controllers/user_controller.dart';
import 'package:tun_tun/app/data/fcm_provider.dart';
import 'package:tun_tun/app/data/models/chatModel.dart';
import 'package:tun_tun/app/data/models/chatRoomModel.dart';
import 'package:tun_tun/app/data/models/userModel.dart';

class RuangObrolanController extends GetxController
    with StateMixin<List<ChatModel>> {
  final userC = UserController.instance;
  final dataC = DatabaseController.instance;
  final fcmProvider = FcmProvider();

  ChatRoom roomModel = Get.arguments[0];
  UserModel receiver = Get.arguments[1];

  final chatTextController = TextEditingController();

  RxList<ChatModel> daftarChat = RxList.empty();

  Future postChat({required ChatModel chatModel, required ChatRoom room}) async {
    var isRoomExist = await dataC.checkRoomExist(id: room.id);

    if (isRoomExist) {
      dataC.addChat(roomModel: roomModel, chatModel: chatModel);
    } else {
      dataC.createChatroom(model: room).then(
          (value) => dataC.addChat(roomModel: room, chatModel: chatModel));
    }
  }

  // Tunanetra session
  late SpeechToText speechToText;

  var recognizedText = "".obs;
  var isEnabled = false.obs;

  void listenSound() async {
    if (!await Permission.microphone.isGranted) {
      Permission.microphone.request();
    } else {
      if (!isEnabled.value) {
        bool availabel = await speechToText.initialize(
          onStatus: (status) {
            if (status == "done") {
              isEnabled.value = false;
              speechToText.stop();
            }
            if (status == "listening") {}
            {
              isEnabled.value == true;
            }
            print(status);
          },
          onError: (errorNotification) {
            print(errorNotification);
          },
        );

        if (availabel) {
          isEnabled.value = true;
          speechToText.listen(
            onResult: (result) {
              recognizedText.value = result.recognizedWords;
            },
          );
        }
      }
    }
  }

  @override
  void onInit() {
    speechToText = SpeechToText();
    daftarChat
        .bindStream(dataC.readChat(roomModel: roomModel).asyncMap((event) {
      change(event, status: RxStatus.success());
      return event;
    }));
    super.onInit();
  }
}
