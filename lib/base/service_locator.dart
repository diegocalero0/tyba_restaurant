import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:localstorage/localstorage.dart';
import 'package:tyba_great_app/constanst/keys_constants.dart';
import 'package:tyba_great_app/use_cases/create_user_use_case.dart';
import 'package:tyba_great_app/use_cases/get_nearby_restaurants_to_location_use_case.dart';
import 'package:tyba_great_app/use_cases/get_searchs_use_case.dart';
import 'package:tyba_great_app/use_cases/get_user_location_use_case.dart';
import 'package:tyba_great_app/use_cases/is_user_logged_use_case.dart';
import 'package:tyba_great_app/use_cases/login_use_case.dart';
import 'package:tyba_great_app/use_cases/logout_use_case.dart';
import 'package:tyba_great_app/use_cases/save_new_search_use_case.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<CreateUserUseCase>(() => CreateUserUseCase());
  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  locator.registerLazySingleton<IsUserLoggedUseCase>(() => IsUserLoggedUseCase());
  locator.registerLazySingleton<GetNearbyRestaurantsToLocationUseCase>(() => GetNearbyRestaurantsToLocationUseCase());
  locator.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase());
  locator.registerLazySingleton<LoginUseCase>(() => LoginUseCase());
  locator.registerLazySingleton<GetUserLocationUseCase>(() => GetUserLocationUseCase());
  locator.registerLazySingleton<LocalStorage>(() => LocalStorage(kKeyLocalStorage));
  locator.registerLazySingleton<SaveNewSearchUseCase>(() => SaveNewSearchUseCase());
  locator.registerLazySingleton<GetSearchsUseCase>(() => GetSearchsUseCase());
}