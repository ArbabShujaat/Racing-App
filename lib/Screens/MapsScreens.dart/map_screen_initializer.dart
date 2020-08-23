


import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:racingApp/Providers/user.dart';
import 'package:racingApp/Screens/MapsScreens.dart/maps_full_screen.dart';
import 'package:racingApp/services/geolocator_service.dart';

class MapInitializer extends StatelessWidget {
  final geoService = GeolocatorService();
  @override
  Widget build(BuildContext context) {
    String currentUserId = Provider.of<User>(context).currentUserId;
    return FutureProvider(
      create: (context) => geoService.getInitialLocation(),
      child: Scaffold(
        body: Consumer<Position>(
            builder: (context, position, widget) {
              return (position != null)
                  ? FullScreenMap(position,currentUserId)
                  : Center(child: CircularProgressIndicator());
            },
          ),
      ),

    );
  }
}