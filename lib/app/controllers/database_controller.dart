import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tun_tun/app/data/models/chatModel.dart';
import 'package:tun_tun/app/data/models/chatRoomModel.dart';
import 'package:tun_tun/app/data/models/userModel.dart';

class DatabaseController extends GetxController {
  static DatabaseController get instance => Get.find();

  /// DATABASE USER
  final _userStore =
      FirebaseFirestore.instance.collection("user").withConverter(
            fromFirestore: (snapshot, options) =>
                UserModel.fromMap(snapshot.data() as Map<String, dynamic>),
            toFirestore: (value, options) => value.toMap(),
          );

  /// DATABASE CHATROOM
  final _chatRoomStore =
      FirebaseFirestore.instance.collection("chatRoom").withConverter(
            fromFirestore: (snapshot, options) =>
                ChatRoom.fromMap(snapshot.data() as Map<String, dynamic>),
            toFirestore: (value, options) => value.toMap(),
          );

  ///
  ///
  /// User Session
  ///
  ///

  /// Masukkan data user ke DATABASE jika Tidak ada
  Future createUser({required UserModel model}) async {
    var userDatabase =
        await _userStore.doc(model.id).get().then((value) => value.exists);
    if (!userDatabase) {
      _userStore.doc(model.id).set(model);
    } else {
      _userStore.doc(model.id).update(
        {"token": model.token},
      );
    }
  }

  /// Update database User
  Future updateUser({required UserModel model}) async {
    _userStore.doc(model.id).update(model.toMap());
  }

  /// Update Nama saja
  Future updateName({required String id, required String name}) async {
    _userStore.doc(id).update({"name": name});
  }

  /// Update Token User
  Future updateTokenUser({required String id, required String token}) async {
    _userStore.doc(id).update({"token": token});
  }

  /// Baca Data diri User
  Stream<UserModel> readUser({required String id}) {
    return _userStore.doc(id).snapshots().map((event) => event.data()!);
  }

  /// Baca Seluruh Data User
  Stream<List<UserModel>> readAllUser() {
    return _userStore.snapshots().map(
          (value) => value.docs
              .map(
                (userModel) => userModel.data(),
              )
              .toList(),
        );
  }

  ///
  ///
  /// CHAT ROOM SESSION
  ///
  ///

  Future createChatroom({required ChatRoom model}) async {
    await _chatRoomStore.doc("${model.id}").set(model);
  }

  Future checkRoomExist({required String id}) async {
    return await _chatRoomStore.doc(id).get().then((value) => value.exists);
  }

  Stream<List<ChatRoom>> readRoom({required String id}) {
    return _chatRoomStore.snapshots().map(
          (rooms) => rooms.docs
              .map(
                (room) => room.data(),
              )
              .where(
                (element) => element.id.contains(id),
              )
              .toList(),
        );
  }

  Future changeAllRoomData(
      {required UserModel userModel, required String name}) async {
    var daftarRuangan = await _chatRoomStore.get().then(
          (value) => value.docs
              .map(
                (data) => data.data(),
              )
              .where(
                (element) => element.id.contains(userModel.id),
              )
              .toList(),
        );
    daftarRuangan.forEach(
      (element) {
        if (userModel.status == "TUNARUNGU") {
          UserModel model = userModel.copyWith(name: name);
          ChatRoom newRoom = element.copyWith(tunarungu: model);
          _chatRoomStore.doc(element.id).update(newRoom.toMap());
        } else {
          UserModel model = userModel.copyWith(name: name);
          ChatRoom newRoom = element.copyWith(tunatera: model);
          _chatRoomStore.doc(element.id).update(newRoom.toMap());
        }
      },
    );
  }

  Stream<ChatRoom> readOneRoom({required ChatRoom roomModel}) {
    return _chatRoomStore
        .doc(roomModel.id)
        .snapshots()
        .map((event) => event.data()!);
  }

  Future updateRoom({required ChatRoom roomModel}) async {
    _chatRoomStore.doc(roomModel.id).update(roomModel.toMap());
  }

  /// Chat Session
  Future addChat(
      {required ChatRoom roomModel, required ChatModel chatModel}) async {
    final _chatStore =
        _chatRoomStore.doc(roomModel.id).collection("chat").withConverter(
              fromFirestore: (snapshot, options) =>
                  ChatModel.fromMap(snapshot.data() as Map<String, dynamic>),
              toFirestore: (value, options) => value.toMap(),
            );

    _chatStore.add(chatModel);
  }

  Stream<List<ChatModel>> readChat({required ChatRoom roomModel}) {
    final _chatStore =
        _chatRoomStore.doc(roomModel.id).collection("chat").withConverter(
              fromFirestore: (snapshot, options) =>
                  ChatModel.fromMap(snapshot.data() as Map<String, dynamic>),
              toFirestore: (value, options) => value.toMap(),
            );

    return _chatStore.snapshots().map(
          (chats) => chats.docs
              .map(
                (chat) => chat.data(),
              )
              .toList(),
        );
  }
}
