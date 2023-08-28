import 'package:get/get.dart';

class FcmProvider extends GetConnect {
  final String fcmUrl = 'https://fcm.googleapis.com/fcm/send';

  final String fcmKey =
      'AAAAcXFZANY:APA91bFv7yHgbQMFtx8JqKbzn8JkIUzkn1N5iSBicu6eL0q2miX5qei78zYs0J2vdFwSj1tZFDU-2MVqmrguDANowACSgNLrWZ6-PavTmb4d7goqgZPHc1KiF-00-MFmioUaM74J636k';

  Future sendChat(
      {required String title,
      required String body,
      required String fcmToken}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$fcmKey'
    };
    var data = {
      "to": fcmToken,
      "priority": "high",
      "notification": {
        "title": title,
        "body": body,
        "sound": "default",
        "channel_id": "order"
      }
    };

    try {
      // var a = await http.post(Uri.parse(httpClient.baseUrl!),
      //     body: jsonEncode(data), headers: headers);

      var a = await post(fcmUrl, data, headers: headers);

      print(a.body);
    } catch (e) {}
  }

  @override
  void onInit() {
    httpClient.baseUrl = 'https://fcm.googleapis.com/fcm/send';
  }
}
