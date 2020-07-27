import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:racingApp/Constants/constant.dart';
import 'package:racingApp/Screens/EventsScreen.dart/EventsScreen.dart';
import 'package:racingApp/Widgets/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:racingApp/models/Events.dart';

class PrimaryScreen extends StatefulWidget {
  @override
  _PrimaryScreenState createState() => _PrimaryScreenState();
}

class _PrimaryScreenState extends State<PrimaryScreen> {
  @override
  void initState() {
    super.initState();
  }

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

    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Image.asset(
            "assets/logo.png",
            width: 70,
            height: 70,
          ),
          centerTitle: true,
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, PROFILE);
              },
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  // child: CircleAvatar(
                  //   backgroundImage: AssetImage("assets/logo.png"),
                  // ),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  )),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background.jpg"),
              fit: BoxFit.cover,
            ),
            color: Colors.white,
          ),
          height: height,
          width: width,
          child: ListView(
            children: <Widget>[
              // Container(
              //   color: Colors.red,
              //   height: 60,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: <Widget>[
              //       SizedBox(
              //         width: 40,
              //       ),
              //       Image.asset("assets/logo.png"),
              //       InkWell(
              //         onTap: () {
              //           Navigator.pushNamed(context, PROFILE);
              //         },
              //         child: Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             // child: CircleAvatar(
              //             //   backgroundImage: AssetImage("assets/logo.png"),
              //             // ),
              //             child: Icon(
              //               Icons.person,
              //               color: Colors.white,
              //               size: 30,
              //             )),
              //       )
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.black.withOpacity(0.6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "LIVE RACERS",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, FULL_MAP);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "See full map",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: height / 2.3,
                width: width,
                child: ListView(
                  children: <Widget>[
                    map(context, width, height),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  color: Colors.black.withOpacity(0.6),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "SHOPS",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text("See all"),

              Container(
                height: height - ((height / 3.5) + height / 3) - 60,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                                image: DecorationImage(
                                  image: AssetImage("assets/car.jpg"),
                                  fit: BoxFit.cover,
                                ),
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              height: 200,
                              width: width / 1.5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                // color: Colors.blue.withOpacity(0.6),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              height: 200,
                              width: width / 1.5,
                              child: Center(
                                  child: Container(
                                color: Colors.black.withOpacity(0.6),
                                child: Text(
                                  "CAR & PARTS",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                            ),
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
                                image: DecorationImage(
                                  image: AssetImage("assets/clothes.jpg"),
                                  fit: BoxFit.cover,
                                ),
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              height: 200,
                              width: width / 1.5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                // color: Colors.blue.withOpacity(0.6),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              height: 200,
                              width: width / 1.5,
                              child: Center(
                                  child: Container(
                                color: Colors.black.withOpacity(0.6),
                                child: Text(
                                  "CLOTHES",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  color: Colors.black.withOpacity(0.6),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "EVENTS",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(
                height: height / 3,
                width: width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: events.length,
                  itemBuilder: (context, index) => eventsItem(index),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget eventsItem(int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventScreen(
                event: events[index],
              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.all(
                Radius.circular(25.0),
              ),
              image: DecorationImage(
                image: AssetImage(events[index].imageUrls[0]),
                fit: BoxFit.cover,
              ),
            ),
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width / 1.3),
      ),
    );
  }

  Widget map(BuildContext context, double screenwidth, double height) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.all(
                  Radius.circular(20.0),
                )),
            height: height / 2.5,
            width: screenwidth,
            child: GoogleMap(
              mapType: MapType.satellite,
              initialCameraPosition: CameraPosition(
                target: LatLng(37.42796133580664, -122.085749655962),
                zoom: 14.4746,
              ),
              onMapCreated: (GoogleMapController controller) {
                CameraPosition(
                    bearing: 192.8334901395799,
                    target: LatLng(37.43296265331129, -122.08832357078792),
                    tilt: 59.440717697143555,
                    zoom: 19.151926040649414);
              },
            ),
          ),
        ],
      ),
    );
  }
}
