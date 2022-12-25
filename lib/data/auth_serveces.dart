import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_chat_app/core/constanst.dart';
import 'package:my_chat_app/core/servece_status.dart';

class AuthServeces {
  Future sendEmail({required String email}) async {
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/user/send-email"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": [email]
        }),
      );
      if (response.statusCode == 200) {
        return Success(code: response.statusCode, response: 'success');
      }
      return const Failure(code: 100, response: 'Invalid Response');
    } catch (e) {
      return const Failure(code: 101, response: 'No Internet');
    }
  }

  Future sendVerify({required String email, required int verifyCode}) async {
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/user/verify-code"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": {
            "email": [email]
          },
          "code": {"code": verifyCode}
        }),
      );
      if (response.statusCode == 200) {
        return Success(
            code: response.statusCode,
            response: jsonDecode(response.body) as Map);
      }
      return const Failure(code: 100, response: 'Invalid Response');
    } catch (e) {
      return const Failure(code: 101, response: 'No Internet');
    }
  }
}
