import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:racingApp/Constants/constant.dart';
import 'package:racingApp/Providers/user.dart';
import 'package:racingApp/Screens/ChatScreens/chat_screen.dart';
import 'package:racingApp/models/Cars.dart';
import 'package:racingApp/services/chat_service.dart';
import 'package:url_launcher/url_launcher.dart';
class DetailsScreen extends StatefulWidget {
  final Productc product;

  const DetailsScreen({Key key, this.product}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  GlobalKey scfkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    UserModel userprofile = Provider.of<User>(context).userProfile;
    return Scaffold(
      key: scfkey,
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
                        image: NetworkImage(widget.product.image), fit: BoxFit.cover)),
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
                              widget.product.title,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                " ${widget.product.price.toString()} \$",
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
                          widget.product.description,
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
                                    receiverEmail: widget.product.sellerEmail,
                                    receiverId: widget.product.sellerUserUid,
                                    receiverName: widget.product.sellerName
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
                    ),

                    if (widget.product.sellerEmail == 'hashimkhan2197@gmail.com')
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
                              onPressed: () {
                                double price = double.parse(widget.product.price);
                                Firestore.instance
                                    .collection('Users')
                                    .document(userprofile.useruid)
                                    .collection('cart')
                                    .add({
                                  'price': price,
                                  'image': widget.product.image,
                                  'name':widget.product.title,
                                  'quantity': 1,
                                  'subtotal': price
                                }).then((value) {
                                  showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(18.0),
                                          side: BorderSide(
                                            color: Colors.red[400],
                                          )),
                                      title: Text('Item Added to Cart.'),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text(
                                            "OK",
                                            style: TextStyle(color: Colors.red[400]),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    ));
                                }).catchError((e) {
                                  showDialog(
                                      context: context,
                                      child: AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(18.0),
                                            side: BorderSide(
                                              color: Colors.red[400],
                                            )),
                                        title: Text('Error. Please Check your internet connection.'),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text(
                                              "OK",
                                              style: TextStyle(color: Colors.red[400]),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ));
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  Text(
                                    "Add to Cart",
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
//                    GestureDetector(
//                      onTap: () {
//                        double price = double.parse(widget.product.price);
//                        Firestore.instance
//                            .collection('Users')
//                            .document(userprofile.useruid)
//                            .collection('cart')
//                            .add({
//                          'price': price,
//                          'image': widget.product.image,
//                          'name':widget.product.title,
//                          'quantity': 1,
//                          'subtotal': price
//                        }).then((value) {
//                          Scaffold.of(context).showSnackBar(SnackBar(
//                            content: Text(
//                              "Item added to cart",
//                              style: TextStyle(fontSize: 18),
//                            ),
//                            backgroundColor: Theme.of(context).accentColor,
//                            duration: Duration(milliseconds: 1000),
//                          ));
//                        }).catchError((e) {
//                          Scaffold.of(context).showSnackBar(SnackBar(
//                            content: Text(
//                              "Error. Please Check your internet connection.",
//                              style: TextStyle(fontSize: 18),
//                            ),
//                            backgroundColor: Theme
//                                .of(context)
//                                .errorColor,
//                            duration: Duration(milliseconds: 1000),
//                          ));
//                        });
//                      },
//                      child: Container(
//                          decoration: BoxDecoration(
//                              color: Theme.of(context).accentColor,
//                              borderRadius: BorderRadius.circular(8)
//                          ),
////                                      RoundedRectangleBorder(
////                                          borderRadius: BorderRadius.circular(30.0)),
//                          alignment: Alignment.center,
//                          height: 32,
//                          width: 65,
//                          child: Text(
//                            'BUY',
//
//                            style: TextStyle(letterSpacing: 1.1,
//                                fontSize: 18,
//                                color:
//                                Colors.white,fontWeight: FontWeight.w400),
//                          )),
//                    )
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

    if(userModel.useruid == widget.product.sellerUserUid){
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
    launch("tel://${widget.product.sellerPhoneNumber}");
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
