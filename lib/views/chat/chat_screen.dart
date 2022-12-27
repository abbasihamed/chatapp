import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:my_chat_app/helper/date_time.dart';
import 'package:my_chat_app/view_model/chat_view_model.dart';

import 'widgets/chat_bubble.dart';

class ChatScreen extends HookWidget {
  final String userEmail;
  const ChatScreen({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = useTextEditingController();
    ValueNotifier<Map> isSelcted = useState({});
    return SafeArea(
      child: Scaffold(
        appBar: isSelcted.value.isNotEmpty
            ? const CustomAppBar()
            : AppBar(
                title: Text(
                  userEmail,
                  style:
                      theme.textTheme.bodyText1!.copyWith(color: Colors.white),
                ),
              ),
        body: Column(
          children: [
            Expanded(
              child: GetX<ChatViewModel>(
                builder: (chat) {
                  return ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: chat.messages.length,
                    itemBuilder: (context, index) {
                      if (chat.messages[index].receiver == userEmail) {
                        return ChatBubble(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          theme: theme,
                          color: Colors.white,
                          isSelcted: isSelcted.value[index] ?? false,
                          message: chat.messages[index].body,
                          time: chat.messages[index].datetime.getTime(),
                          onLongPress: () {
                            isSelcted.value = {index: true};
                          },
                          onTap: () {
                            if (isSelcted.value.isNotEmpty) {
                              isSelcted.value = {};
                            }
                          },
                        );
                      }
                      return ChatBubble(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        theme: theme,
                        color: Colors.green[500]!,
                        isSelcted: isSelcted.value[index] ?? false,
                        message: chat.messages[index].body,
                        time: chat.messages[index].datetime.getTime(),
                        onLongPress: () {},
                        onTap: () {},
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey[300]!,
                  blurRadius: 15,
                  spreadRadius: 2,
                  offset: const Offset(0, 1),
                )
              ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      minLines: 1,
                      maxLines: 5,
                      style: theme.textTheme.bodyText1,
                      controller: controller,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      decoration: InputDecoration(
                        hintText: 'Message',
                        hintStyle: theme.textTheme.caption,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    child: IconButton(
                      onPressed: () {
                        Get.find<ChatViewModel>().sendMessage(
                          reciever: userEmail,
                          body: controller.text,
                        );
                        controller.clear();
                      },
                      highlightColor: Colors.transparent,
                      icon: Icon(
                        Icons.send,
                        size: 24,
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar();
  }
}
