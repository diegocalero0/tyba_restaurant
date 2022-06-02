import 'package:firebase_auth/firebase_auth.dart';
import 'package:tyba_great_app/base/service_locator.dart';

class IsUserLoggedUseCase {
  final FirebaseAuth _firebaseAuthInstance;

  IsUserLoggedUseCase({
    FirebaseAuth? firebaseAuthInstance
  }): _firebaseAuthInstance = firebaseAuthInstance ?? locator.get<FirebaseAuth>();

  bool invoke() {
    return _firebaseAuthInstance.currentUser != null;
  }
}