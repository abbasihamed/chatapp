import 'package:flutter/material.dart';

import '../injection.dart';
import '../views/auth/auth_screen.dart';
import '../views/home/home_screen.dart';
import '../views/logic/shared_controller.dart';

Widget? startScreen;

getStart() async {
  final token = await inject.get<SharedController>().getData(key: 'token');
  if (token != null) {
    startScreen = const HomeScreen();
    return;
  }
  startScreen = const AuthScreen();
}
