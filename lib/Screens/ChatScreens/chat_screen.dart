import 'package:flutter/material.dart';

import 'chat/messages.dart';
import 'chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  final String chatRoomId;
  final String otherSenderName;
  final String receiverId;
  ChatScreen(this.chatRoomId,this.otherSenderName,this.receiverId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(otherSenderName),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(chatRoomId),
            ),
            NewMessage(chatRoomId,receiverId),
          ],
        ),
      ),
    );
  }
}
