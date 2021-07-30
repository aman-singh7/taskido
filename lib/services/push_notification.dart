import 'package:dio/dio.dart';
import 'package:task_dot_do/ui/constants/server_key.dart';

class PushNotification {
  final _dio = Dio();
  final _key = server_key;

  Future<void> sendFCM(
      List<String> tokens, String groupName, String title) async {
    final url = 'https://fcm.googleapis.com/fcm/send';
    var data = {
      'registration_ids': tokens,
      'priority': 'high',
      'notification': {
        'title': groupName,
        'body': title,
        'sound': 'default',
      }
    };
    try {
      var response = await _dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            'Content-type': 'application/json',
            'Authorization': 'key=$_key',
          },
        ),
      );
      if (response.statusCode == 200) {
        print(response.data);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
