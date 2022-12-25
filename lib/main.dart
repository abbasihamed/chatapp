import 'package:flutter/material.dart';
import 'package:my_chat_app/core/start_screen.dart';
import 'package:my_chat_app/injection.dart';

import 'config/theme.dart';
import 'core/constanst.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  
  setup();

  await getStart();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyChat',
      navigatorKey: navKey,
      theme: AppTheme.appTheme,
      home: startScreen,
    );
  }
}
