import 'dart:convert';

import 'package:get/get.dart';
import 'package:my_chat_app/core/enums.dart';
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
        if (temp['request_mode'] == ChatEnum.delete.name) {
          deleteMessage(temp['body']);
        }
        if (temp['request_mode'] == ChatEnum.message.name) {
          _messages.add(Message.fromJson(temp));
        }
      }
      if (temp.runtimeType == List) {
        _rooms.value = roomsModelFromJson(event);
      }
    });
  }

  socketConnection(
      {required Enum mode, required String body, String? reciever}) {
    if (mode == ChatEnum.message) {
      sendMessage(
        reciever: reciever!,
        body: body,
        mode: ChatEnum.message,
      );
      return;
    }
    if (mode == ChatEnum.delete) {
      sendDelete(
        messageId: body,
        mode: ChatEnum.delete,
      );
      return;
    }
  }

  sendDelete({
    required String messageId,
    required Enum mode,
  }) async {
    final sender = await shared.getData(key: 'email');
    channel!.sink.add(jsonEncode({
      "request_mode": mode.name,
      "sender": sender,
      "body": messageId,
    }));
  }

  sendMessage({
    required String reciever,
    required String body,
    required Enum mode,
  }) async {
    final sender = await shared.getData(key: 'email');
    channel!.sink.add(jsonEncode({
      "request_mode": mode.name,
      "sender": sender,
      "receiver": reciever,
      "body": body.trim(),
      "room_name": _roomName ?? sender + reciever,
    }));
  }

  setOldMessageList(ChatsModel value) {
    for (var element in value.messages) {
      if (element.viewers.contains(_email)) {
        _messages.add(element);
      }
    }
  }

  deleteMessage(String value) {
    for (int i = 0; i < _messages.length; i++) {
      if (_messages[i].id == value) {
        _messages.removeAt(i);
      }
    }
  }

  setRoomName(ChatsModel value) {
    _roomName = value.roomName;
  }

  getOldMessage(String receiver) async {
    _email = await shared.getData(key: 'email');
    var response =
        await chatSocket.getOldMessages(sender: _email, receiver: receiver);
    if (response is Success) {
      _messages.clear();
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
