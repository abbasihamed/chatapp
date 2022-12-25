import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_chat_app/core/constanst.dart';
import 'package:my_chat_app/core/servece_status.dart';
import 'package:my_chat_app/data/auth_serveces.dart';
import 'package:my_chat_app/injection.dart';
import 'package:my_chat_app/views/home/home_screen.dart';
import 'package:my_chat_app/views/logic/shared_controller.dart';

class AuthViewModel extends GetxController {
  final authServece = inject.get<AuthServeces>();
  final shared = inject.get<SharedController>();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    update();
  }

  sendEmail(String email) async {
    setLoading(true);
    var response = await authServece.sendEmail(email: email);
    if (response is Success) {
      setLoading(false);
      shared.saveDate(key: 'email', value: email);
    }
    setLoading(false);
  }

  sendVerifyCode(String code) async {
    final email = await shared.getData(key: 'email');
    var response =
        await authServece.sendVerify(email: email, verifyCode: int.parse(code));
    if (response is Success) {
      Map token = response.response as Map;
      shared.saveDate(key: 'token', value: token['token']);
      navKey.currentState!.push(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }
}
