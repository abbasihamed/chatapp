
import 'package:my_chat_app/core/constanst.dart';
import 'package:my_chat_app/core/servece_status.dart';
import 'package:my_chat_app/models/chat_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

class ChatServece {
  chatSocketConnection({required String email}) {
    var channel = WebSocketChannel.connect(
      Uri.parse('ws://10.0.2.2:8000/email=$email'),
    );
    return channel;
  }

  Future getOldMessages(
      {required String sender, required String receiver}) async {
    try {
      var response = await http.get(
        Uri.parse(
            '$baseUrl/get-old-message/sender=$sender/receiver=$receiver'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return Success(
            code: 200,
            response: chatsModelFromJson(response.body));
      }
      return const Failure(code: 404, response: 'Invalid response');
    } catch (e) {
      return const Failure(code: 101, response: 'Unkown Error');
    }
  }
}
