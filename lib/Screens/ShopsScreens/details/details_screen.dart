import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:racingApp/Constants/constant.dart';
import 'package:racingApp/Providers/user.dart';
import 'package:racingApp/Screens/ChatScreens/chat_screen.dart';
import 'package:racingApp/models/Cars.dart';
import 'package:racingApp/services/chat_service.dart';
import 'package:url_launcher/url_launcher.dart';
class DetailsScreen extends StatelessWidget {
  final Productc product;

  const DetailsScreen({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // each product have a color

        appBar: buildAppBar(context),
        body: Container(
          height: height,
          width: width,
          child: ListView(
            children: <Widget>[
              Container(
                height: height / 2.5,
                width: width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(product.image), fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: height - (height / 2.5) - 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Text(
                              product.title,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                " ${product.price.toString()} \$",
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          product.description,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ButtonTheme(
                            minWidth: 300.0,
                            height: 50.0,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(color: Colors.red)),
                              color: primarycolor,
                              onPressed: (){
                                initiateChatConversation(
                                    ctx: context,
                                    receiverEmail: product.sellerEmail,
                                    receiverId: product.sellerUserUid,
                                    receiverName: product.sellerName
                                );
                              },
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.message,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  Text(
                                    "Contact Seller",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ButtonTheme(
                            minWidth: 300.0,
                            height: 50.0,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(color: Colors.red)),
                              color: primarycolor,
                              onPressed: (){
                                initiateCall(ctx: context);
                              },
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  Text(
                                    "Contact Seller",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  /// 1.create a chatroom, send user to the chatroom, other userdetails
  void initiateChatConversation(
      {BuildContext ctx,
        String receiverName,
        receiverEmail,
        receiverId}) async {
    UserModel userModel = Provider.of<User>(ctx).userProfile;

    if(userModel.useruid == receiverId){
      showDialog(
          context: ctx,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(
                  color: Colors.red[400],
                )),
            title: Text('This product is yours. You cannot text yourself.'),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.red[400]),
                ),
                onPressed: () {
                  Navigator.pop(ctx);
                },
              )
            ],
          ));
      return;
    }

    List<String> userNames = [userModel.name, receiverName];
    List<String> userEmails = [userModel.email, receiverEmail];
    List<String> userUids = [userModel.useruid, receiverId];

    String chatRoomId =
    ChatService.getChatRoomId(userModel.useruid, receiverId);

    Map<String, dynamic> chatRoom = {
      "usernames": userNames,
      'useremails': userEmails,
      'useruids': userUids,
      "chatRoomId": chatRoomId,
    };

    await ChatService.addChatRoom(chatRoom, chatRoomId);

    Navigator.push(
        ctx,
        MaterialPageRoute(
            builder: (context) => ChatScreen(chatRoomId, receiverName,receiverId)));
  }

  Future<void> initiateCall(
      {BuildContext ctx}) async {
    UserModel userModel = Provider.of<User>(ctx).userProfile;

    if(userModel.useruid == product.sellerUserUid){
      showDialog(
          context: ctx,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(
                  color: Colors.red[400],
                )),
            title: Text('This product is yours. You cannot call yourself.'),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.red[400]),
                ),
                onPressed: () {
                  Navigator.pop(ctx);
                },
              )
            ],
          ));
      return;
    }
    launch("tel://${product.sellerPhoneNumber}");
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
