import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  static Future<bool> addChatRoom(chatRoom, chatRoomId) async {
    QuerySnapshot chatRoomChecker = await Firestore.instance
        .collection('chat')
        .where("chatRoomId", isEqualTo: chatRoomId)
        .getDocuments()
        .catchError((e) {
      print(e);
    });

    if (chatRoomChecker.documents.length != 0) {
      return true;
    } else {
      await Firestore.instance
          .collection("chat")
          .document(chatRoomId)
          .setData(chatRoom)
          .catchError((e) {
        print(e);
      });
      return true;
    }
  }

  static String getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}
