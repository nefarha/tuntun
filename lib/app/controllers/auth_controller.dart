import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tun_tun/app/controllers/database_controller.dart';
import 'package:tun_tun/app/data/dialogModel.dart';
import 'package:tun_tun/app/data/models/userModel.dart';
import 'package:tun_tun/app/data/reusable.dart';
import 'package:tun_tun/app/routes/app_pages.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  final _instance = FirebaseAuth.instance;
  final dataC = DatabaseController.instance;

  Rx<User?> get currentUser => Rx(_instance.currentUser);

  Future phoneAuthSignIn(
      {required String? phoneNumber,
      required String status,
      required String token}) async {
    _instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) async {
        try {
          await _instance.signInWithCredential(phoneAuthCredential).then(
            (value) {
              UserModel model = UserModel(
                  id: value.user!.uid,
                  name: "",
                  status: status,
                  phone: value.user!.phoneNumber!,
                  token: token);

              dataC.createUser(model: model);
            },
          );

          Get.offAllNamed(Routes.HOME);
        } on FirebaseAuthException catch (e) {
          if (e.code == "invalid-verification-code") {
            DialogModel.ErrorDialog("Kode verifikasi salah");
          } else {
            DialogModel.ErrorDialog("Terjadi suatu kesalahan");
          }
        }
      },
      verificationFailed: (FirebaseAuthException error) {
        if (error.code == "too-many-requests") {
          DialogModel.ErrorDialog(
              "Terlalu sering mengirim code, Device ditangguhkan beberapa saat, Silahkan coba beberapa saat");
        } else if (error.code == 'invalid-phone-number') {
          DialogModel.ErrorDialog("Nomor telephone salah");
        } else if (error.code == "session-expired") {
          DialogModel.ErrorDialog("SILAHKAN KIRIM ULANG KDOE");
        } else
          DialogModel.ErrorDialog(error.toString());
      },
      codeSent: (verificationId, forceResendingToken) async {
        await Reusable.askingSMSCode(
            verificationId: verificationId,
            instance: _instance,
            status: status,
            token: token,
            dataC: dataC);
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  Future logout() async {
    _instance.signOut();
    Get.offAllNamed(Routes.BOARDING);
  }

  Future updateName({required String nama}) async {
    await _instance.currentUser!.updateDisplayName(nama);
    currentUser.bindStream(_instance.userChanges());
    Get.offAllNamed(Routes.HOME);
  }

  Future changeName({required String nama}) async {
    await _instance.currentUser!.updateDisplayName(nama);
    currentUser.bindStream(_instance.userChanges());
  }

  @override
  void onInit() {
    currentUser.bindStream(_instance.authStateChanges());
    super.onInit();
  }
}
