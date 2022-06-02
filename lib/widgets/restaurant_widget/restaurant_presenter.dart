import 'package:flutter/material.dart';
import 'package:tyba_great_app/base/base_state.dart';
import 'package:tyba_great_app/models/get_nearby_restaurants_response_model.dart';

abstract class RestaurantWidgetDelegate<T extends StatefulWidget> extends BaseState<T> {
  
}

class RestaurantPresenter {

  PlaceModel? restaurant;
  List<String> images = [];
  RestaurantWidgetDelegate? mView;

  Future<void> getRestaurantImages() async {

  }

}