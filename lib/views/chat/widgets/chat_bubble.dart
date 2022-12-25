import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final ThemeData theme;
  final String message;
  final String time;
  final Color color;
  final CrossAxisAlignment crossAxisAlignment;
  const ChatBubble({
    Key? key,
    required this.theme,
    required this.message,
    required this.time,
    required this.color,
    required this.crossAxisAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message,
                  style: theme.textTheme.bodyText1,
                ),
                Text(
                  '  $time',
                  style: theme.textTheme.caption!.copyWith(
                    fontSize: 12,
                    color: Colors.green[800],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
