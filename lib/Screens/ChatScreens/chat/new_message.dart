import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:racingApp/Providers/user.dart';

class NewMessage extends StatefulWidget {
  final chatRoomID;
  final receiverid;
  NewMessage(this.chatRoomID,this.receiverid);
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final userProfile = Provider.of<User>(context).userProfile;
    Firestore.instance.collection('chat').document(widget.chatRoomID).collection('messages').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': userProfile.useruid,
      'username': userProfile.name,
      'receiveruid': widget.receiverid
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.send,
            ),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}
