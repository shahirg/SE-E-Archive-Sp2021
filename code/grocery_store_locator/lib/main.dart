/// written by Dymytriy Zyunkin
/// tested by Dymytriy Zyunkin
/// debugged by Dymytriy Zyunkin

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grocery_locator/models/place.dart';
import 'package:grocery_locator/services/geolocator_service.dart';
import 'package:grocery_locator/services/places_service.dart';
import 'package:provider/provider.dart';
import 'screens/search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final locatorService = GeoLocatorService();
  final placesService = PlacesService();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(create: (context) => locatorService.getLocation()),
        ProxyProvider<Position, Future<List<Place>>>(
          update: (context, position, places) {
            return (position != null)
                ? placesService.getPlaces(position.latitude, position.longitude)
                : null;
          },
        )
      ],
      child: MaterialApp(
        title: 'Grocery Store Locator',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: Search(),
      ),
    );
  }
}
