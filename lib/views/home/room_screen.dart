import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:my_chat_app/config/theme.dart';
import 'package:my_chat_app/core/constanst.dart';
import 'package:my_chat_app/helper/date_time.dart';
import 'package:my_chat_app/view_model/chat_view_model.dart';
import 'package:my_chat_app/views/home/widgets/rooms_list_item.dart';
import 'package:my_chat_app/views/search/search_screen.dart';
import 'package:my_chat_app/views/widgets/app_loading.dart';

class RoomsScreen extends HookWidget {
  // final ThemeData theme;
  final Function(String) onTap;

  const RoomsScreen({
    super.key,
    // required this.theme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'MyChat',
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text('hamedabbasi'),
                accountEmail: const Text('hamed137881@gmail.com'),
                otherAccountsPictures: [
                  ThemeSwitcher.withTheme(builder: (context, switcher, theme) {
                    return IconButton(
                      onPressed: () {
                        switcher.changeTheme(
                          theme: theme.brightness == Brightness.light
                              ? AppTheme.darkTheme
                              : AppTheme.lightTheme,
                        );
                      },
                      icon: const Icon(Icons.mode_night_rounded),
                    );
                  })
                ],
              )
            ],
          ),
        ),
        body: GetX<ChatViewModel>(
          builder: (chat) {
            return ListView.separated(
              itemCount: chat.rooms.isNotEmpty ? chat.rooms.length : 1,
              itemBuilder: (context, index) {
                if (chat.isLoading) {
                  return const AppLoading();
                }
                return InkWell(
                  hoverColor: Colors.transparent,
                  onTap: () {
                    onTap(
                        chat.rooms[index].roomName.replaceAll(chat.email, ''));
                  },
                  child: RoomsListItem(
                    roomName:
                        chat.rooms[index].roomName.replaceAll(chat.email, ''),
                    lastMessage: chat.rooms[index].messages.body,
                    time: chat.rooms[index].messages.datetime.getTime(),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(
                indent: 80,
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.search),
          onPressed: () {
            navKey.currentState!.push(
              MaterialPageRoute(
                builder: (context) => const SearchScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
