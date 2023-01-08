import 'package:flutter/material.dart';

class RoomsListItem extends StatelessWidget {
  final String roomName;
  final String lastMessage;
  final String time;
  const RoomsListItem({
    super.key,
    required this.roomName,
    required this.lastMessage,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(),
      title: Text(
        roomName,
        style: const TextStyle(
          letterSpacing: 0.2,
          wordSpacing: 1.5,
          fontWeight: FontWeight.w900,
        ),
      ),
      subtitle: Text(
        lastMessage,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Color(0xFF9899A5),
          fontSize: 12,
        ),
      ),
      trailing: Text(
        time,
      ),
    );
  }
}
