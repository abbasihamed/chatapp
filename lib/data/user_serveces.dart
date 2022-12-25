import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_chat_app/core/constanst.dart';
import 'package:my_chat_app/core/servece_status.dart';

import '../models/search_user_models.dart';

class UserServeces {
  Future usersSearch({required String email}) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/user/search-user'),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
        }),
      );
      if (response.statusCode == 200) {
        return Success(
            code: 200, response: searchUserModelFromJson(response.body));
      }
      return const Failure(code: 100, response: 'Invalid response');
    } catch (e) {
      return const Failure(code: 101, response: 'Unkown Error');
    }
  }
}
