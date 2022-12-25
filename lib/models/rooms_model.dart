import 'dart:convert';

List<RoomsModel> roomsModelFromJson(String str) =>
    List<RoomsModel>.from(json.decode(str).map((x) => RoomsModel.fromJson(x)));

String roomsModelToJson(List<RoomsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RoomsModel {
  final String id;
  final String roomName;
  final Messages messages;

  RoomsModel({
    required this.id,
    required this.roomName,
    required this.messages,
  });

  factory RoomsModel.fromJson(Map<String, dynamic> json) => RoomsModel(
        id: json["id"],
        roomName: json["room_name"],
        messages: Messages.fromJson(json["messages"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "room_name": roomName,
        "messages": messages.toJson(),
      };
}

class Messages {
  final String sender;
  final String receiver;
  final String body;
  final DateTime datetime;

  Messages({
    required this.sender,
    required this.receiver,
    required this.body,
    required this.datetime,
  });

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        sender: json["sender"],
        receiver: json["receiver"],
        body: json["body"],
        datetime: DateTime.parse(json["datetime"]),
      );

  Map<String, dynamic> toJson() => {
        "sender": sender,
        "receiver": receiver,
        "body": body,
        "datetime": datetime.toIso8601String(),
      };
}
