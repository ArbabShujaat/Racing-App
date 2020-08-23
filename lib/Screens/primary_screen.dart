import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:racingApp/Constants/constant.dart';
import 'package:racingApp/Providers/user.dart';
import 'package:racingApp/Screens/EventsScreen.dart/EventsScreen.dart';
import 'package:racingApp/Screens/MapsScreens.dart/map_screen_initializer.dart';
import 'package:racingApp/Widgets/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:racingApp/models/Events.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:io';

class PrimaryScreen extends StatefulWidget {
  @override
  _PrimaryScreenState createState() => _PrimaryScreenState();
}

class _PrimaryScreenState extends State<PrimaryScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    double _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    bool _large = ResponsiveWidget.isScreenLarge(width, _pixelRatio);
    bool _medium = ResponsiveWidget.isScreenMedium(width, _pixelRatio);
    bool _small = ResponsiveWidget.isScreenSmall(width, _pixelRatio);
    print(width * _pixelRatio);
    print(_pixelRatio);
    print(_large);
    print(_small);
    print(_medium);

    ///Main ui function for screen
    return Material(
      child: Scaffold(

          ///appbar
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text("RACING APP"),
            // title: Image.asset(
            //   "assets/logo.png",
            //   width: 70,
            //   height: 70,
            // ),
            centerTitle: true,
          ),
          body: Container(
            decoration: BoxDecoration(
              // image: DecorationImage(
              //   image: AssetImage("assets/background.jpg"),
              //   fit: BoxFit.cover,
              // ),
              color: Colors.white,
            ),
            height: height,
            width: width,
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),

                ///This container contains the half screen map on the screen
                Container(
                  height: height / 3.8,
                  width: width / 2,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "LIVE MAP",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                              child: map(context, width / 1.3, height / 4.8)),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "EVENTS",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          events(context, width / 1.3, height / 4.8),
                        ],
                      ),
                    ],
                  ),
                ),

                ///Shops section starts here
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        "SHOPS",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),

                Container(
                  height: height - ((height / 3.5) + height / 3) - 160,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, CAR_SHOP_PAGE);
                          },
                          child: Stack(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.2),
                                        offset: Offset(6, 2),
                                        blurRadius: 6.0,
                                        spreadRadius: 3.0),
                                    BoxShadow(
                                        color:
                                            Color.fromRGBO(255, 255, 255, 0.9),
                                        offset: Offset(-6, -2),
                                        blurRadius: 6.0,
                                        spreadRadius: 3.0)
                                  ],
                                  image: DecorationImage(
                                    image: AssetImage("assets/car.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                height: 200,
                                width: width / 2.2,
                              ),
                              // Container(
                              //   decoration: BoxDecoration(
                              //     // color: Colors.blue.withOpacity(0.6),
                              //     borderRadius:
                              //         BorderRadius.all(Radius.circular(20)),
                              //   ),
                              //   height: 200,
                              //   width: width / 2.2,
                              //   child: Center(
                              //       child: Container(
                              //     color: Colors.black.withOpacity(0.6),
                              //     child: Text(
                              //       "CAR & PARTS",
                              //       style: TextStyle(
                              //           color: Colors.white,
                              //           fontSize: 25,
                              //           fontWeight: FontWeight.bold),
                              //     ),
                              //   )),
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, CLOTHES_SHOP_PAGE);
                          },
                          child: Stack(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.2),
                                        offset: Offset(6, 2),
                                        blurRadius: 6.0,
                                        spreadRadius: 3.0),
                                    BoxShadow(
                                        color:
                                            Color.fromRGBO(255, 255, 255, 0.9),
                                        offset: Offset(-6, -2),
                                        blurRadius: 6.0,
                                        spreadRadius: 3.0)
                                  ],
                                  image: DecorationImage(
                                      image: AssetImage("assets/clothes.jpg"),
                                      fit: BoxFit.scaleDown),
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                height: 200,
                                width: width / 2.2,
                              ),

                              // Container(
                              //   decoration: BoxDecoration(
                              //     // color: Colors.blue.withOpacity(0.6),
                              //     borderRadius:
                              //         BorderRadius.all(Radius.circular(20)),
                              //   ),
                              //   height: 200,
                              //   width: width / 2.2,
                              //   child: Center(
                              //       child: Container(
                              //     color: Colors.black.withOpacity(0.6),
                              //     child: Text(
                              //       "CLOTHES",
                              //       style: TextStyle(
                              //           color: Colors.white,
                              //           fontSize: 25,
                              //           fontWeight: FontWeight.bold),
                              //     ),
                              //   )),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "ADVERTISEMENT",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6, right: 6, top: 0),
                  child: Container(
                    height: height / 4.5,
                    width: width,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                            offset: Offset(6, 2),
                            blurRadius: 6.0,
                            spreadRadius: 3.0),
                        BoxShadow(
                            color: Color.fromRGBO(255, 255, 255, 0.9),
                            offset: Offset(-6, -2),
                            blurRadius: 6.0,
                            spreadRadius: 3.0)
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Carousel(
                        overlayShadow: false,
                        dotBgColor: Colors.transparent,
                        // dotSize: 15,
                        // dotIncreaseSize: 10,
                        dotSize: 6,
                        dotSpacing: 30,
                        dotIncreasedColor: Colors.red,
                        dotColor: Colors.red,
                        images: [
                          Image.asset(
                            "assets/ad2.jpeg",
                            fit: BoxFit.fill,
                          ),
                          Image.asset(
                            "assets/ad1.jpeg",
                            fit: BoxFit.fill,
                          ),
                          Image.asset(
                            "assets/ad3.jpeg",
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                ///Events section starts here
                // Container(
                //   color: Colors.black.withOpacity(0.6),
                //   child: Padding(
                //     padding: const EdgeInsets.only(left: 8.0),
                //     child: Text(
                //       "EVENTS",
                //       style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 20,
                //           fontWeight: FontWeight.bold),
                //     ),
                //   ),
                // ),

                // Container(
                //   height: height / 3,
                //   width: width,
                //   child: StreamBuilder(
                //       stream: Firestore.instance
                //           .collection('events')
                //           .orderBy('timestamp', descending: true)
                //           .snapshots(),
                //       builder: (context, AsyncSnapshot snapshot) {
                //         if (snapshot.connectionState == ConnectionState.waiting) {
                //           return Center(
                //             child: CircularProgressIndicator(),
                //           );
                //         }
                //         final snapShotData = snapshot.data.documents;
                //         if (snapShotData.length == 0) {
                //           return Center(
                //             child: Text("No products added"),
                //           );
                //         }
                //         return ListView.builder(
                //           scrollDirection: Axis.horizontal,
                //           itemCount: snapShotData.length,
                //           itemBuilder: (context, index) {
                //             var eventItem = snapShotData[index].data;
                //             return eventsItem(Events(
                //                 imageUrls: eventItem['eventimages'],
                //                 date: eventItem['eventdate'],
                //                 description: eventItem['eventdescription'],
                //                 id: eventItem['eventid'],
                //                 title: eventItem['title']));
                //           },
                //         );
                //       }),
                // ),

                // SizedBox(
                //   height: 20,
                // )
              ],
            ),
          ),
          drawer: drawer()),
    );
  }

  /////////////////Events///////////////////
  Widget events(BuildContext context, double screenwidth, double height) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Container(
              decoration: new BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/event.jpg",
                      ),
                      fit: BoxFit.fill),
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(
                    Radius.circular(20.0),
                  )),
              height: height,
              width: screenwidth,
            ),
          ),
          Positioned(
            top: 8,
            left: 13,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(18)),
                color: Colors.black.withOpacity(0.6),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "4 Events",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 10,
            child: RaisedButton(
              color: Colors.red,
              onPressed: () {
                Navigator.pushNamed(context, EVENTLIST_SCREEN);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red)),
              child: Text(
                "SEE ALL",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  ////////////Drawer///////////

  Widget drawer() {
    return Drawer(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.red,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 8, 8, 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '''Welcome User !!''',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            // Text(
                            //   '''UserName''',
                            //   style: TextStyle(
                            //       color: Colors.white,
                            //       fontSize: 15,
                            //       fontWeight: FontWeight.bold),
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 8,
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, PROFILE);
              },
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.red,
                ),
                title: Text(
                  "ACCOUNT ",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Divider(
                color: Colors.red,
                thickness: 2,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, FULL_MAP);
              },
              child: ListTile(
                leading: Icon(
                  Icons.map,
                  color: Colors.red,
                ),
                title: Text(
                  "LIVE MAP",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Divider(
                color: Colors.red,
                thickness: 2,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, CHAT_SCREEN);
              },
              child: ListTile(
                leading: Icon(
                  Icons.message,
                  color: Colors.red,
                ),
                title: Text(
                  "MY CHAT",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Divider(
                color: Colors.red,
                thickness: 2,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, CAR_SHOP_PAGE);
              },
              child: ListTile(
                leading: Icon(
                  Ionicons.ios_car,
                  color: Colors.red,
                ),
                title: Text(
                  "CARS FOR SALE",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Divider(
                color: Colors.red,
                thickness: 2,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, CAR_SHOP_PAGE);
              },
              child: ListTile(
                leading: Icon(
                  FontAwesome.gears,
                  color: Colors.red,
                ),
                title: Text(
                  "PARTS FOR SALE",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Divider(
                color: Colors.red,
                thickness: 2,
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.phone,
                  color: Colors.red,
                ),
                title: Text(
                  "CONTACT US ",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Divider(
                color: Colors.red,
                thickness: 2,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                              contentPadding: EdgeInsets.only(
                                  left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
                              children: <Widget>[
                                Container(
                                  color: Colors.red,
                                  margin: EdgeInsets.all(0.0),
                                  padding:
                                      EdgeInsets.only(bottom: 10.0, top: 10.0),
                                  height: 100.0,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: Icon(
                                          Icons.exit_to_app,
                                          size: 30.0,
                                          color: Colors.white,
                                        ),
                                        margin: EdgeInsets.only(bottom: 10.0),
                                      ),
                                      Text(
                                        'Log Out',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Are you sure to Log Out?',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                ),
                                SimpleDialogOption(
                                  onPressed: () {
                                    Navigator.pop(context, 0);
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        child: Icon(
                                          Icons.cancel,
                                          color: Colors.black,
                                        ),
                                        margin: EdgeInsets.only(right: 10.0),
                                      ),
                                      Text(
                                        'CANCEL',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                SimpleDialogOption(
                                  onPressed: () {
                                    handleSignOut().then((onValue) {});
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        child: Icon(
                                          Icons.check_circle,
                                          color: Colors.black,
                                        ),
                                        margin: EdgeInsets.only(right: 10.0),
                                      ),
                                      Text(
                                        'YES',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    child: Text("LOGOUT",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  ///THis function the half page ui on the screen
  Widget map(BuildContext context, double screenwidth, double height) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Stack(
        children: <Widget>[
          Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(
                    Radius.circular(20.0),
                  )),
              height: height,
              width: screenwidth,
              child: MapInitializer()),
          Positioned(
            top: 8,
            left: 13,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(18)),
                color: Colors.black.withOpacity(0.6),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Online( 21 )",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 10,
            child: RaisedButton(
              color: Colors.red,
              onPressed: () {
                Navigator.pushNamed(context, FULL_MAP);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red)),
              child: Text(
                "Full Map",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    final fbm = FirebaseMessaging();
    if (Platform.isIOS) {
      fbm.onIosSettingsRegistered.listen((event) {
        _saveDeviceToken(fbm);
      });
      fbm.requestNotificationPermissions(IosNotificationSettings());
    } else {
      _saveDeviceToken(fbm);
    }

    fbm.configure(
      onMessage: (msg) {
        print(msg);

        final snackbar = SnackBar(
          content: Text(msg['notification']['title']),
          action: SnackBarAction(
            label: 'See',
            onPressed: () {},
          ),
        );
        Scaffold.of(context).showSnackBar(snackbar);
        return;
      },
      onLaunch: (msg) {
        print(msg);
        return;
      },
      onResume: (msg) {
        print(msg);
        return;
      },
    );
    fbm.subscribeToTopic('chat');
    super.initState();
  }

  _saveDeviceToken(var fbm) async {
    //UserModel user = Provider.of<User>(context).userProfile;

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String fcmtoken = await fbm.getToken();
    if (fcmtoken != null) {
      await Firestore.instance
          .collection("Users")
          .document(user.uid)
          .collection('tokens')
          .document(fcmtoken)
          .setData({
        'token': fcmtoken,
        'createdAt': FieldValue.serverTimestamp(),
        'platform': Platform.operatingSystem
      });
    }
  }

  Future<Null> handleSignOut() async {
    await FirebaseAuth.instance.signOut();
//              var prefs = await SharedPreferences.getInstance();
//              prefs.clear();
    Navigator.pushReplacementNamed(context, LOGIN_SCREEN);
  }
}
