import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:my_chat_app/view_model/chat_view_model.dart';
import 'package:my_chat_app/views/chat/chat_screen.dart';
import 'package:my_chat_app/views/home/room_screen.dart';

class HomeScreen extends StatefulHookWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollPhysics scrollPhysics = const NeverScrollableScrollPhysics();
  String email = '';
  @override
  Widget build(BuildContext context) {
    Get.put(ChatViewModel());
    final pageController = usePageController(viewportFraction: 1);
    // final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        if (pageController.page == 0.0) {
          return true;
        }
        pageController.animateToPage(0,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
        return false;
      },
      child: SafeArea(
        child: PageView(
          controller: pageController,
          physics: scrollPhysics,
          onPageChanged: (value) {
            if (value == 0) {
              scrollPhysics = const NeverScrollableScrollPhysics();
              setState(() {});
            }
          },
          children: [
            RoomsScreen(
              onTap: (value) {
                scrollPhysics = const AlwaysScrollableScrollPhysics();
                pageController.animateToPage(1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn);
                email = value;
                Get.find<ChatViewModel>().getOldMessage(email);
                setState(() {});
              },
            ),
            ChatScreen(
              userEmail: email,
            )
          ],
        ),
      ),
    );
  }
}
