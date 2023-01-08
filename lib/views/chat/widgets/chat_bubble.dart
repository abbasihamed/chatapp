import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String time;
  final Color color;
  final bool isSelcted;
  final Alignment alignment;
  final VoidCallback onLongPress;
  final VoidCallback onTap;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.time,
    required this.color,
    required this.isSelcted,
    required this.alignment,
    required this.onLongPress,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Stack(
          alignment: alignment,
          children: [
            Material(
              borderRadius: BorderRadius.circular(16),
              elevation: 2,
              color: color,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        message,
                        style: const TextStyle(
                          color: Color(0xFFF5F5F5),
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Text(
                      '  $time',
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF9899A5)),
                    ),
                  ],
                ),
              ),
            ),
            if (isSelcted)
              Positioned.fill(
                child: Container(
                  decoration:
                      BoxDecoration(color: const Color(0xFFB1B3C1).withOpacity(0.5)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
