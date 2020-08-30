import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:racingApp/Constants/constant.dart';
import 'package:racingApp/models/Events.dart';

class EventScreen extends StatelessWidget {
  final Events event;

  const EventScreen({Key key, this.event}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        // each event have a color

        appBar: AppBar(
          title: Text(event.title),
          centerTitle: true,
          actions: <Widget>[
//        IconButton(
//          icon: SvgPicture.asset(
//            "assets/icons/search.svg",
//            // By default our  icon color is white
//            color: Colors.white,
//          ),
//          onPressed: () {},
//        ),
            SizedBox(width: kDefaultPaddin / 2),
            SizedBox(width: kDefaultPaddin / 2),
          ],
        ),
        body: Container(
          height: height,
          width: width,
          child: ListView(
            children: <Widget>[
              Container(
                color: Colors.white,
                height: height / 2,
                width: width,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 400.0,
                    initialPage: 0,
                    reverse: false,
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                  items: event.imageUrls.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(i), fit: BoxFit.cover)),
                        );
                      },
                    );
                  }).toList(),
                ),
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
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Text(
                              event.title,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              event.date,
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          event.description,
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
