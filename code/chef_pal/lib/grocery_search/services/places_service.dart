import 'package:chef_pal/grocery_search/models/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  final key = 'AIzaSyBbbEcuJdA_rJk_JJyef1z3XYKsyLmOATQ';

  // /maps/api/place/nearbysearch/json?location=$lat,$lng&type=grocery&rankby=distance&key=$key

  Future<List<Place>> getPlaces(double lat, double lng) async {
    String _baseURL = 'maps.googleapis.com';
    Map<String, String> parameters = {
      'location': '$lat,$lng',
      'type': 'grocery',
      'rankby': 'distance',
      'key': key
    };
    var response = await http.get(
      Uri.https(_baseURL, '/maps/api/place/nearbysearch/json', parameters),
    );
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}
