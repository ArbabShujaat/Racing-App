import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.userName, this.isMe,this.timestamp, {this.key});

  final Timestamp timestamp;
  final Key key;
  final String message;
  final String userName;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.white70 : Theme.of(context).accentColor,
            border: Border.all(color: isMe ? Colors.grey : Theme.of(context).accentColor,width: 1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
            ),
          ),
          width: MediaQuery.of(context).size.width * .55,
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 8,
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
//              Text(
//                userName,
//                style: TextStyle(
//                  fontSize: 18,
//                  fontWeight: FontWeight.bold,
//                  color: isMe
//                      ? Colors.black
//                      : Theme.of(context).accentTextTheme.title.color,
//                ),
//              ),
              Text(
                message,
                style: TextStyle(
                  fontSize: 18,
                  color: isMe
                      ? Colors.black87
                      : Theme.of(context).accentTextTheme.title.color,
                ),
                textAlign: isMe ? TextAlign.start : TextAlign.start,
              ),
              Text(
                '${timestamp.toDate().toString().split(' ').first}',
                style: TextStyle(
                  color: isMe ? Colors.red: Colors.white70,
                ),
                textAlign: isMe ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
