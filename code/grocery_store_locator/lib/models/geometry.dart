// written by Dymytriy Zyunkin
// tested by Dymytriy Zyunkin
// debugged by Dymytriy Zyunkin

import 'package:grocery_locator/models/location.dart';

class Geometry {
  final Location location;

  Geometry({this.location});
  Geometry.fromJson(Map<dynamic, dynamic> parsedJson)
      : location = Location.fromJson(parsedJson['location']);
}
