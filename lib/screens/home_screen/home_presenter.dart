
import 'package:flutter/material.dart';
import 'package:tyba_great_app/base/base_state.dart';
import 'package:tyba_great_app/base/service_locator.dart';
import 'package:tyba_great_app/models/get_nearby_restaurants_response_model.dart';
import 'package:tyba_great_app/use_cases/get_nearby_restaurants_to_location_use_case.dart';
import 'package:tyba_great_app/use_cases/get_user_location_use_case.dart';
import 'package:tyba_great_app/use_cases/logout_use_case.dart';
import 'package:tyba_great_app/use_cases/save_new_search_use_case.dart';

abstract class HomeScreenDelegate<T extends StatefulWidget> extends BaseState<T> {
  void navigateToLogin();
  void navigateToHistory();
  void resetSearch();
}

class HomePresenter {
  
  final GetNearbyRestaurantsToLocationUseCase _getNearbyRestaurantsToLocationUseCase;
  final GetUserLocationUseCase _getUserLocationUseCase;
  final LogoutUseCase _logoutUseCase;
  final SaveNewSearchUseCase _saveNewSearchUseCase;
  HomeScreenDelegate? mView;

  HomePresenter({
    GetNearbyRestaurantsToLocationUseCase? getNearbyRestaurantsToLocationUseCase,
    GetUserLocationUseCase? getUserLocationUseCase,
    LogoutUseCase? logoutUseCase,
    SaveNewSearchUseCase? saveNewSearchUseCase
  }): _getNearbyRestaurantsToLocationUseCase = getNearbyRestaurantsToLocationUseCase ?? locator.get<GetNearbyRestaurantsToLocationUseCase>(),
    _getUserLocationUseCase = getUserLocationUseCase ?? locator.get<GetUserLocationUseCase>(),
    _logoutUseCase = logoutUseCase ?? locator.get<LogoutUseCase>(),
    _saveNewSearchUseCase = saveNewSearchUseCase ?? locator.get<SaveNewSearchUseCase>();

  List<PlaceModel> restaurants = [];

  Future<void> getNearbyRestaurants({String text = "", bool showInUserLocation = false}) async {
    if(text.trim().isNotEmpty) {
      await _saveNewSearchUseCase.invoke(text);
    }
    mView?.showLoader();

    double? latitude;
    double? longitude;

    if(showInUserLocation) {
      try {
        final position = await _getUserLocationUseCase.invoke();
        latitude = position?.latitude;
        longitude = position?.longitude;
      } catch(e) {
        mView?.hideLoader();
        mView?.showAlert(e.toString());
        mView?.resetSearch();
        return;
      }
    }

    
    try {
      restaurants = await _getNearbyRestaurantsToLocationUseCase.invoke("Restaurantes en $text", latitude, longitude);
      mView?.hideLoader();
      mView?.refreshScreen();
    } catch(e) {
      mView?.hideLoader();
      mView?.showAlert(e.toString());
    }
  }

  Future<void> logout() async {
    await _logoutUseCase.invoke();
    mView?.navigateToLogin();
  }
}