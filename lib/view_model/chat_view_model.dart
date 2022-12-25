import 'dart:convert';

import 'package:get/get.dart';
import 'package:my_chat_app/core/servece_status.dart';
import 'package:my_chat_app/data/chat_serveces.dart';
import 'package:my_chat_app/injection.dart';
import 'package:my_chat_app/models/chat_model.dart';
import 'package:my_chat_app/models/rooms_model.dart';
import 'package:my_chat_app/views/logic/shared_controller.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatViewModel extends GetxController {
  final chatSocket = inject.get<ChatServece>();
  final shared = inject.get<SharedController>();

  final RxList<Message> _messages = <Message>[].obs;
  final RxList<RoomsModel> _rooms = <RoomsModel>[].obs;

  String? _roomName;

  String _email = '';

  List<Message> get messages => _messages.reversed.toList();
  List<RoomsModel> get rooms => _rooms;
  String get email => _email;

  WebSocketChannel? channel;

  chatStreamConnection(String email) {
    channel = chatSocket.chatSocketConnection(email: email);
    channel!.stream.listen((event) {
      var temp = jsonDecode(event);
      if (temp.runtimeType != List) {
        _messages.add(Message.fromJson(jsonDecode(event)));
      } else {
        _rooms.value = roomsModelFromJson(event);
      }
    });
  }

  sendMessage({required String reciever, required String body}) async {
    final sender = await shared.getData(key: 'email');
    channel!.sink.add(jsonEncode({
      "sender": sender,
      "receiver": reciever,
      "body": body.trim(),
      "room_name": _roomName ?? sender + reciever,
    }));
  }

  setOldMessageList(ChatsModel value) {
    _messages.value = value.messages;
  }

  setRoomName(ChatsModel value) {
    _roomName = value.roomName;
  }

  getOldMessage(String receiver) async {
    _email = await shared.getData(key: 'email');
    var response =
        await chatSocket.getOldMessages(sender: _email, receiver: receiver);
    if (response is Success) {
      setOldMessageList(response.response as ChatsModel);
      setRoomName(response.response as ChatsModel);
    }
    if (response is Failure) {
      _messages.clear();
      _roomName = null;
    }
  }

  initialData() async {
    _email = await shared.getData(key: 'email');
    chatStreamConnection(email);
  }

  @override
  void onInit() {
    super.onInit();
    initialData();
  }
}
