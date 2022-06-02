import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:tyba_great_app/base/service_locator.dart';
import 'package:tyba_great_app/constanst/keys_constants.dart';

class GetSearchsUseCase {

  final LocalStorage _storage;

  GetSearchsUseCase({
    LocalStorage? storage
  }): _storage = storage ?? locator.get<LocalStorage>();
  
  Future<List<String>> invoke() async {

    
    final searchsMap = await _storage.getItem(kKeyLocalStorageLastSearchs);
    if(searchsMap != null) {
      return (searchsMap as List<dynamic>).map((e) => e.toString()).toList();
    } else {
      return [];
    }    
  }
}