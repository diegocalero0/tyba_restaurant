import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:tyba_great_app/base/service_locator.dart';
import 'package:tyba_great_app/constanst/keys_constants.dart';

class SaveNewSearchUseCase {

  final LocalStorage _storage;

  SaveNewSearchUseCase({
    LocalStorage? storage
  }): _storage = storage ?? locator.get<LocalStorage>();
  
  Future<void> invoke(String text) async {

    
    final searchsMap = _storage.getItem(kKeyLocalStorageLastSearchs);

    if(searchsMap == null) {
      await _storage.setItem(kKeyLocalStorageLastSearchs, [text]);
    } else {
      (searchsMap as List<dynamic>).add(text);
      await _storage.setItem(kKeyLocalStorageLastSearchs, searchsMap);
    }
  }
}