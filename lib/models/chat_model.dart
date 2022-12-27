import 'dart:convert';

ChatsModel chatsModelFromJson(String str) =>
    ChatsModel.fromJson(json.decode(str));

List<Message> messageModelFromJson(String str) => List<Message>.from(
    json.decode(str)['messages'].map((x) => Message.fromJson(x)));

String chatsModelToJson(ChatsModel data) => json.encode(data.toJson());

class ChatsModel {
  final String id;
  final String roomName;
  final List<String> members;
  final List<Message> messages;

  ChatsModel({
    required this.id,
    required this.roomName,
    required this.members,
    required this.messages,
  });

  factory ChatsModel.fromJson(Map<String, dynamic> json) => ChatsModel(
        id: json["id"],
        roomName: json["room_name"],
        members: List<String>.from(json["members"].map((x) => x)),
        messages: List<Message>.from(
            json["messages"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "room_name": roomName,
        "members": List<dynamic>.from(members.map((x) => x)),
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
      };
}

class Message {
  final String? id;
  final String sender;
  final String receiver;
  final String body;
  final List? viewers;
  final DateTime datetime;

  Message({
     this.id,
    required this.sender,
    required this.receiver,
    required this.body,
     this.viewers,
    required this.datetime,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        sender: json["sender"],
        receiver: json["receiver"],
        body: json["body"],
        viewers: json["viewers"],
        datetime: DateTime.parse(json["datetime"]),
      );

  Map<String, dynamic> toJson() => {
        "sender": sender,
        "receiver": receiver,
        "body": body,
        "datetime": datetime.toIso8601String(),
      };
}
