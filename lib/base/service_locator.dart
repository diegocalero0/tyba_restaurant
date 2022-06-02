import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:tyba_great_app/use_cases/create_user_use_case.dart';
import 'package:tyba_great_app/use_cases/is_user_logged_use_case.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<CreateUserUseCase>(() => CreateUserUseCase());
  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  locator.registerLazySingleton<IsUserLoggedUseCase>(() => IsUserLoggedUseCase());
}