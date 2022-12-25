import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_chat_app/core/constanst.dart';
import 'package:my_chat_app/view_model/chat_view_model.dart';
import 'package:my_chat_app/view_model/search_user_view_model.dart';
import 'package:my_chat_app/views/chat/chat_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Get.lazyPut(() => SearchUsersViewModel());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          title: TextFormField(
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              hintStyle: theme.textTheme.caption!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              hintText: 'Search',
              border: InputBorder.none,
            ),
            onChanged: (value) {
              Get.find<SearchUsersViewModel>().setEmailText(value);
            },
          ),
        ),
        body: GetBuilder<SearchUsersViewModel>(builder: (controller) {
          return ListView.separated(
            itemCount: controller.searchList.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                navKey.currentState!.push(
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      userEmail: controller.searchList[index].email,
                    ),
                  ),
                );
                Get.find<ChatViewModel>()
                    .getOldMessage(controller.searchList[index].email);
              },
              child: ListTile(
                title: Text(controller.searchList[index].email),
                leading: const CircleAvatar(),
              ),
            ),
            separatorBuilder: (context, index) => const Divider(indent: 80),
          );
        }),
      ),
    );
  }
}
