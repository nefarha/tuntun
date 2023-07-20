import 'package:get/get.dart';

class FcmProvider extends GetConnect {
  final String fcmUrl = 'https://fcm.googleapis.com/fcm/send';

  final String fcmKey =
      'AAAAQ0OBQw0:APA91bH9ClSVDjotSGFKcnJYMWqoDYrArK3VpCKcdcv17BR9bNnqPIKL_9D2nSAyYjaNQGpQ72v9R-pOc0sN4P7PPnkAwGREt_ofAV-dxhgSqOM9fJixIsSGPib8k6UKfJBEfqQbOxiV';

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
