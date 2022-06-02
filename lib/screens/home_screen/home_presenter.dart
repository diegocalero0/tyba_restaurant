
import 'package:flutter/material.dart';
import 'package:tyba_great_app/base/base_state.dart';

abstract class HomeScreenDelegate<T extends StatefulWidget> extends BaseState<T> {
  void navigateToLogin();
  void navigateToHistory();
}

class HomePresenter {
  
  HomeScreenDelegate? mView;
}