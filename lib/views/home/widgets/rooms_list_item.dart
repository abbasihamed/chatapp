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
    final theme = Theme.of(context).textTheme;
    return ListTile(
      leading: const CircleAvatar(),
      title: Text(
        roomName,
        style: theme.bodyText1,
      ),
      subtitle: Text(
        lastMessage,
        style: theme.subtitle1,
      ),
      trailing: Text(
        time,
        style: theme.subtitle1,
      ),
    );
  }
}
