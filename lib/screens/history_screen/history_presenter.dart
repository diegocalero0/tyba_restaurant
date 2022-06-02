import 'package:flutter/material.dart';
import 'package:tyba_great_app/base/base_state.dart';
import 'package:tyba_great_app/base/service_locator.dart';
import 'package:tyba_great_app/use_cases/get_searchs_use_case.dart';

abstract class HistoryScreenDelegate<T extends StatefulWidget> extends BaseState<T> {
  
}

class HistoryPresenter {

  final GetSearchsUseCase _getSearchsUseCase;
  HistoryScreenDelegate? mView;

  HistoryPresenter({
    GetSearchsUseCase? getSearchsUseCase
  }): _getSearchsUseCase = getSearchsUseCase ?? locator.get<GetSearchsUseCase>();

  
  List<String> searchs = [];

  Future<void> getSearchs() async {
    mView?.showLoader();
    try {
      searchs = await _getSearchsUseCase.invoke();
      mView?.hideLoader();
      mView?.refreshScreen();
    } catch(e) {
      mView?.hideLoader();
      mView?.showAlert("Ocurrió un error obteniendo tus búsquedas recientes", action: mView?.goBack);
    }
  }

}