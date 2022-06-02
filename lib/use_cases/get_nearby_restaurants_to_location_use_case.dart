import 'dart:convert';

import 'package:tyba_great_app/models/get_nearby_restaurants_response_model.dart';
import 'package:http/http.dart' as http;

class GetNearbyRestaurantsToLocationUseCase {

  Future<List<PlaceModel>> invoke(String query, double? latitude, double? longitude) async {
    
    String url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&radius=1500&key=AIzaSyCCuDblWjG2ioJCw_wVXRAjc7YHQbjFwxw";

    if(latitude != null && longitude != null) {
      url += "&location=$latitude,$longitude";
    }

    print(url);

    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri, headers: {
        "Accept": "application/json"
      });
      
      if(response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final GetNearbyRestaurantsResponseModel getNearbyRestaurantsResponseModel
          =  GetNearbyRestaurantsResponseModel.fromJson(responseBody);

        return getNearbyRestaurantsResponseModel.results ?? [];
      } else {
        throw("Ocurrió un error obteniendo los restaurantes, código de error: ${response.statusCode}");
      }
    } catch(e) {
      rethrow;
    }
  }
}