import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racingApp/Constants/constant.dart';
import 'package:racingApp/Providers/user.dart';
import 'package:racingApp/Screens/ChatScreens/chat_screen.dart';

class AllChatsScreen extends StatefulWidget {
  @override
  _AllChatsScreenState createState() => _AllChatsScreenState();
}

class _AllChatsScreenState extends State<AllChatsScreen> {
  UserModel _userProfile;

  @override
  Widget build(BuildContext context) {
    _userProfile = Provider.of<User>(context).userProfile;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarycolor,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
          child: Text(
            "Chats",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        centerTitle: true,
//        actions: <Widget>[
//          InkWell(
//            onTap: () {
//              Navigator.push(context, MaterialPageRoute(builder: (context){
//                return AllChatsScreen();
//              }));
//            },
//            child: Padding(
//                padding: const EdgeInsets.all(8.0),
//                // child: CircleAvatar(
//                //   backgroundImage: AssetImage("assets/logo.png"),
//                // ),
//                child: Icon(
//                  Icons.chat,
//                  color: Colors.white,
//                  size: 30,
//                )),
//          ),
//          InkWell(
//            onTap: () {
//              Navigator.pushNamed(context, PROFILE);
//            },
//            child: Padding(
//                padding: const EdgeInsets.all(8.0),
//                // child: CircleAvatar(
//                //   backgroundImage: AssetImage("assets/logo.png"),
//                // ),
//                child: Icon(
//                  Icons.person,
//                  color: Colors.white,
//                  size: 30,
//                )),
//          )
//        ],
      ),
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance
              .collection('chat')
          .where('useremails',arrayContains: _userProfile.email)
//              .where('userids', arrayContains: _userProfile.useruid)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final snapShotData = snapshot.data.documents;
            if (snapShotData.length == 0) {
              return Center(
                child: Text("No chats yet."),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                DocumentSnapshot data = snapShotData[index];
                String otherSenderName = findOtherSenderName(data);
                String otherSenderEmail = findOtherSenderEmail(data);
                String otherSenderUid = findOtherSenderId(data);
                return Container(
                  margin: EdgeInsets.all(6),
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  )),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ChatScreen(data.documentID, otherSenderName,otherSenderUid);
                      }));
                    },
                    title: Text(
                      otherSenderName,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(otherSenderEmail,
                    style: TextStyle(fontSize: 20,color: Colors.grey),),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_forever,size: 35,color: Colors.red,),
                      onPressed: () {
                        Firestore.instance
                            .collection('chat')
                            .document(data.documentID)
                            .delete()
                            .catchError((err) {
                          print(err);
                        });
                      },
                    ),
                  ),
                );
              },
              itemCount: snapshot.data.documents.length,
            );
          },
        ),
      ),
    );
  }

  String findOtherSenderName(DocumentSnapshot data) {
    List<dynamic> userNames = data.data['usernames'];

    userNames.remove(_userProfile.name);
    return userNames[0];
  }

  String findOtherSenderEmail(DocumentSnapshot data) {
    List<dynamic> userEmails = data.data['useremails'];

    userEmails.remove(_userProfile.email);
    return userEmails[0];
  }
  String findOtherSenderId(DocumentSnapshot data) {
    List<dynamic> userids = data.data['useruids'];

    userids.remove(_userProfile.useruid);
    return userids[0];
  }

}
