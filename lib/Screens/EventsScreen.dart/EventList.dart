import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:racingApp/models/Events.dart';

import 'EventsScreen.dart';

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Events List"),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.grey[300],
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder(
              stream: Firestore.instance
                  .collection('events')
                  .orderBy('timestamp', descending: true)
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
                    child: Text("No products added"),
                  );
                }
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapShotData.length,
                  itemBuilder: (context, index) {
                    var eventItem = snapShotData[index].data;
                    return eventsItem(Events(
                        imageUrls: eventItem['eventimages'],
                        date: eventItem['eventdate'],
                        description: eventItem['eventdescription'],
                        id: eventItem['eventid'],
                        title: eventItem['title']));
                  },
                );
              }),
        ),
      ),
    );
  }

  ///Function creates an event item ui that is then placed in a list
  ///and goes to event screen on tap
  Widget eventsItem(Events event) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventScreen(
                event: event,
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
                image: NetworkImage(event.imageUrls[0]),
                fit: BoxFit.cover,
              ),
            ),
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width / 1.3),
      ),
    );
  }
}
