import 'package:flutter/material.dart';
import 'package:tyba_great_app/base/base_state.dart';
import 'package:tyba_great_app/base/service_locator.dart';
import 'package:tyba_great_app/use_cases/is_user_logged_use_case.dart';

abstract class SplashScreenDelegate<T extends StatefulWidget> extends BaseState<T> {
  void navigateToLogin();
  void navigateToHome();
}

class SplashPresenter {

  final IsUserLoggedUseCase _isUserLoggedUseCase;
  SplashScreenDelegate? mView;

  SplashPresenter({
    IsUserLoggedUseCase? isUserLoggedUseCase
  }): _isUserLoggedUseCase = isUserLoggedUseCase ?? locator.get<IsUserLoggedUseCase>();

  Future<void> checkIfUserIsLogged() async {
    Future.delayed(const Duration(seconds: 2), () {
      if(_isUserLoggedUseCase.invoke()) {
        mView?.navigateToHome();
      } else {
        mView?.navigateToLogin();
      }
    });
  }
}