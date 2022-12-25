import 'dart:convert';

List<SearchUserModel> searchUserModelFromJson(String str) =>
    List<SearchUserModel>.from(
        json.decode(str).map((x) => SearchUserModel.fromJson(x)));

String searchUserModelToJson(List<SearchUserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchUserModel {
  final String id;
  final String email;

  SearchUserModel({
    required this.id,
    required this.email,
  });

  factory SearchUserModel.fromJson(Map<String, dynamic> json) =>
      SearchUserModel(
        id: json["id"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
      };
}
