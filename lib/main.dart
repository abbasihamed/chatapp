import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:my_chat_app/core/start_screen.dart';
import 'package:my_chat_app/injection.dart';

import 'config/theme.dart';
import 'core/constanst.dart';

void main(List<String> args) async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  setup();

  await getStart();

  runApp(const MyApp());

  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: AppTheme.lightTheme,
      builder: (context,theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyChat',
          navigatorKey: navKey,
          theme: theme,
          home: startScreen,
        );
      }
    );
  }
}
