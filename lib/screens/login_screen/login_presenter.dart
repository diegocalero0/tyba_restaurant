import 'package:flutter/material.dart';
import 'package:tyba_great_app/base/base_state.dart';
import 'package:tyba_great_app/base/service_locator.dart';
import 'package:tyba_great_app/use_cases/login_use_case.dart';

abstract class LoginScreenDelegate<T extends StatefulWidget> extends BaseState<T> {
  void navigateToHome();
}

class LoginPresenter {

  final LoginUseCase _loginUseCase;

  LoginPresenter({
    LoginUseCase? loginUseCase
  }): _loginUseCase = loginUseCase ?? locator.get<LoginUseCase>();

  LoginScreenDelegate? mView;

  Future<void> login(String email, String password) async {
    mView?.showLoader();
    try {
      final credential = await _loginUseCase.invoke(email, password);
      mView?.hideLoader();
      mView?.navigateToHome();
    } catch(e) {
      mView?.hideLoader();
      mView?.showAlert(e.toString());
    }
  }
}