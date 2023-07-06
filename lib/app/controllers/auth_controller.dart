import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tun_tun/app/data/dialogModel.dart';
import 'package:tun_tun/app/data/reusable.dart';
import 'package:tun_tun/app/routes/app_pages.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  final _instance = FirebaseAuth.instance;

  Rx<User?> get currentUser => Rx(_instance.currentUser);

  Future phoneAuthSignIn({required String? phoneNumber}) async {
    _instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) {
        _instance.signInWithCredential(phoneAuthCredential);
        Get.offAllNamed(Routes.HOME);
      },
      verificationFailed: (error) {
        DialogModel.ErrorDialog("Terjadi kesalahan");
      },
      codeSent: (verificationId, forceResendingToken) async {
        String? smsCode = await Reusable.askingSMSCode();

        if (smsCode != null) {
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);

          try {
            await _instance.signInWithCredential(credential);
            Get.offAllNamed(Routes.HOME);
          } on FirebaseAuthException catch (e) {
            if (e.code == "invalid-verification-code") {
              DialogModel.ErrorDialog("Kode verifikasi salah");
            } else {
              DialogModel.ErrorDialog("Terjadi suatu kesalahan");
            }
          }
        }
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

  @override
  void onInit() {
    currentUser.bindStream(_instance.authStateChanges());
    super.onInit();
  }
}
