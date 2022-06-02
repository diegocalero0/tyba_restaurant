import 'package:firebase_auth/firebase_auth.dart';
import 'package:tyba_great_app/base/service_locator.dart';

class LogoutUseCase {

  final FirebaseAuth _firebaseAuthInstance;

  LogoutUseCase({
    FirebaseAuth? firebaseAuthInstance
  }): _firebaseAuthInstance = firebaseAuthInstance ?? locator.get<FirebaseAuth>();

  Future<bool> invoke() async {
    await _firebaseAuthInstance.signOut();
    return true;
  }
}