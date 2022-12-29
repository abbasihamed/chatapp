import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:my_chat_app/core/enums.dart';
import 'package:my_chat_app/helper/date_time.dart';
import 'package:my_chat_app/view_model/chat_view_model.dart';
import 'package:my_chat_app/views/widgets/app_loading.dart';

import 'widgets/chat_bubble.dart';

class ChatScreen extends HookWidget {
  final String userEmail;
  const ChatScreen({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = useTextEditingController();
    final chat = useState(Get.find<ChatViewModel>());
    final messageId = useState('');
    ValueNotifier<Map> isSelcted = useState({});
    return SafeArea(
      child: Scaffold(
        appBar: isSelcted.value.isNotEmpty
            ? CustomAppBar(
                onPresses: () {
                  Get.find<ChatViewModel>().socketConnection(
                    mode: ChatEnum.delete,
                    body: messageId.value,
                  );
                  isSelcted.value = {};
                },
              )
            : AppBar(
                title: Text(
                  userEmail,
                  style:
                      theme.textTheme.bodyText1!.copyWith(color: Colors.white),
                ),
              ),
        body: Column(
          children: [
            if (chat.value.isLoading) const Padding(
              padding:  EdgeInsets.only(top: 12),
              child:  AppLoading(),
            ),
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          theme: theme,
                          color: Colors.white,
                          isSelcted: isSelcted.value[index] ?? false,
                          message: chat.messages[index].body,
                          time: chat.messages[index].datetime.getTime(),
                          onLongPress: () {
                            isSelcted.value = {index: true};
                            messageId.value = chat.messages[index].id;
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        theme: theme,
                        color: Colors.green[500]!,
                        isSelcted: isSelcted.value[index] ?? false,
                        message: chat.messages[index].body,
                        time: chat.messages[index].datetime.getTime(),
                        onLongPress: () {
                          isSelcted.value = {index: true};
                          messageId.value = chat.messages[index].id;
                        },
                        onTap: () {
                          if (isSelcted.value.isNotEmpty) {
                            isSelcted.value = {};
                          }
                        },
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
                        chat.value.socketConnection(
                          mode: ChatEnum.message,
                          body: controller.text,
                          reciever: userEmail,
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
  final VoidCallback onPresses;
  const CustomAppBar({
    super.key,
    required this.onPresses,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: onPresses,
          icon: const Icon(Icons.delete_outline),
        )
      ],
    );
  }
}
