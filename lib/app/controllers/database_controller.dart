import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tun_tun/app/data/models/userModel.dart';

class DatabaseController extends GetxController {
  static DatabaseController get instance => Get.find();

  final _userStore =
      FirebaseFirestore.instance.collection("user").withConverter(
            fromFirestore: (snapshot, options) =>
                UserModel.fromMap(snapshot.data() as Map<String, dynamic>),
            toFirestore: (value, options) => value.toMap(),
          );

  Future createUser({required UserModel model}) async {
    _userStore.doc(model.id).set(model);
  }

  Future updateUser({required UserModel model}) async {
    _userStore.doc(model.id).update(model.toMap());
  }
}
