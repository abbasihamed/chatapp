import 'package:get_it/get_it.dart';
import 'package:my_chat_app/data/auth_serveces.dart';
import 'package:my_chat_app/data/chat_serveces.dart';
import 'package:my_chat_app/data/user_serveces.dart';
import 'package:my_chat_app/views/logic/shared_controller.dart';

var inject = GetIt.I;

void setup() {
  inject.registerSingleton(SharedController());
  inject.registerSingleton(ChatServece());

  inject.registerLazySingleton(() => AuthServeces());
  inject.registerLazySingleton(() => UserServeces());
}
