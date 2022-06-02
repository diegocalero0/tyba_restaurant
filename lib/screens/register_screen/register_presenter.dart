import 'package:flutter/material.dart';
import 'package:tyba_great_app/base/base_state.dart';
import 'package:tyba_great_app/base/service_locator.dart';
import 'package:tyba_great_app/use_cases/create_user_use_case.dart';

abstract class RegisterScreenDelegate<T extends StatefulWidget> extends BaseState<T> {
  void navigateToHome();
}

class RegisterPresenter {

  final CreateUserUseCase _createUserUseCase;

  RegisterPresenter({
    CreateUserUseCase? createUserUseCase
  }): _createUserUseCase = createUserUseCase ?? locator.get<CreateUserUseCase>();
  

  RegisterScreenDelegate? mView;

  Future<void> createUser(String email, String password) async {
    mView?.showLoader();

    try {
      final credential = await _createUserUseCase.invoke(email, password);
      mView?.hideLoader();
      mView?.showAlert("Usuario creado correctamente", action: mView?.navigateToHome); 
    } catch(e) {
      mView?.hideLoader();
      mView?.showAlert(e.toString());
    }

  }
}
