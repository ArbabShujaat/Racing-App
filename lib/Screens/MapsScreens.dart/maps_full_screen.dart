import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:racingApp/Providers/user.dart';
import 'package:racingApp/Screens/ChatScreens/chat_screen.dart';
import 'package:racingApp/services/chat_service.dart';
import 'package:racingApp/services/geolocator_service.dart';
import 'package:url_launcher/url_launcher.dart';

class FullScreenMap extends StatefulWidget {
  final Position initialPosition;
  final String currentUserid;

  FullScreenMap(this.initialPosition, this.currentUserid);
  @override
  _FullScreenMapState createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  final GeolocatorService geoService = GeolocatorService();
  Completer<GoogleMapController> _controller = Completer();

  List<Marker> _markers = [];
  StreamSubscription<QuerySnapshot> _markerStreamSubscription;
  StreamSubscription<dynamic> _positionStream;

  ///updating markers stream
  void _updateMarkers(List<DocumentSnapshot> documentList) {
    List<Marker> markers = [];
    documentList.forEach((DocumentSnapshot document) {
      if (document.data['lat'] != null &&
          document.data['useruid'] != widget.currentUserid) {
        markers.add(Marker(
          markerId: MarkerId(document.documentID),
          draggable: false,
          onTap: () {
            showDialog(
                context: context,
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(
                        color: Colors.red[400],
                      )),
                  title: Text("Racer Details"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            maxRadius: 30,
                            backgroundColor: Theme.of(context).primaryColor,
                            backgroundImage:
                                NetworkImage(document.data['userimage']),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              document.data['name'],
                              softWrap: true,
                              maxLines: 2,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          document.data['vehicedetails'],
                          maxLines: 5,
                          softWrap: true,
                          style: TextStyle(color: Colors.grey, fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Icon(
                        Icons.call,
                        size: 25,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        launch("tel://${document.data['phoneNumber']}");
                      },
                    ),
                    FlatButton(
                      child: Icon(
                        Icons.message,
                        size: 25,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        initiateChatConversation(
                            ctx: context,
                            receiverName: document.data['name'],
                            receiverId: document.data['useruid'],
                            receiverEmail: document.data['email']);
                      },
                    )
                  ],
                ));
          },
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(document.data['lat'], document.data['lng']),
        ));
      }
    });
    _markers = markers;
    setState(() {});
    print("Markers Length: " + _markers.toString());
  }

  /// 1.create a chatroom, send user to the chatroom, other userdetails
  void initiateChatConversation(
      {BuildContext ctx,
      String receiverName,
      receiverEmail,
      receiverId}) async {
    UserModel userProfile = Provider.of<User>(context).userProfile;
    List<String> userNames = [userProfile.name, receiverName];
    List<String> userEmails = [userProfile.email, receiverEmail];
    List<String> userUids = [userProfile.useruid, receiverId];

    String chatRoomId =
        ChatService.getChatRoomId(userProfile.useruid, receiverId);

    Map<String, dynamic> chatRoom = {
      "usernames": userNames,
      'useremails': userEmails,
      'useruids': userUids,
      "chatRoomId": chatRoomId,
    };

    await ChatService.addChatRoom(chatRoom, chatRoomId);

    Navigator.pushReplacement(
        ctx,
        MaterialPageRoute(
            builder: (context) =>
                ChatScreen(chatRoomId, receiverName, receiverId)));
  }

  @override
  void initState() {
    _positionStream = geoService.getCurrentLocation().listen((position) {
      Firestore.instance
          .collection('Users')
          .document(widget.currentUserid)
          .updateData({'lat': position.latitude, 'lng': position.longitude});
      print(position.toString());
      centerScreen(position);
    });

    _markerStreamSubscription = Firestore.instance
        .collection("Users")
        .where('location', isEqualTo: 'disabled')
        .snapshots()
        .listen((snapshot) {
      print("lenght of stream" + snapshot.documents.length.toString());
      _updateMarkers(snapshot.documents);
    });

    super.initState();
  }

  @override
  void dispose() {
    _markerStreamSubscription.cancel();
    _positionStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
//        appBar: AppBar(
//          title: Text("LIVE RACERS"),
//          actions: <Widget>[
//            InkWell(
//              onTap: () {},
//              child: Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Row(
//                    children: <Widget>[
//                      Text(
//                        "Enable ",
//                        style: TextStyle(color: Colors.white),
//                      ),
//                      Icon(
//                        Icons.location_on,
//                        color: Colors.white,
//                        size: 25,
//                      ),
//                    ],
//                  )),
//            )
//          ],
//        ),

        ///body to mark all available racers
        body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            height: height,
            width: width,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(widget.initialPosition.latitude,
                        widget.initialPosition.longitude),
                    zoom: 18.151926040649414,
                    bearing: 192.8334901395799,
                    tilt: 59.440717697143555),
                mapType: MapType.satellite,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                markers: Set.from(_markers),
                zoomControlsEnabled: false,
                compassEnabled: false,
//                    onTap: (LatLng p){
////                      Firestore.instance.collection("Users").add({
////                        'lat' : p.latitude,
////                        'lng' : p.longitude,
////                      });
//                    },
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            )));
  }

  Future<void> centerScreen(Position position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 18.151926040649414,
        bearing: 192.8334901395799,
        tilt: 59.440717697143555)));
  }
}
