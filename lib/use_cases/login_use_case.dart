import 'package:firebase_auth/firebase_auth.dart';
import 'package:tyba_great_app/base/service_locator.dart';

class LoginUseCase {

  final FirebaseAuth _firebaseAuthInstance;

  LoginUseCase({
    FirebaseAuth? firebaseAuthInstance
  }): _firebaseAuthInstance = firebaseAuthInstance ?? locator.get<FirebaseAuth>();

  Future<UserCredential?> invoke(String email, String password) async {
    try {
      final credential = await _firebaseAuthInstance
      .signInWithEmailAndPassword(email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw("EL correo electrónico ingresado no se encuentra registrado.");
      } else if (e.code == 'wrong-password') {
        throw("La contraseña ingresada no es válida.");
      }
    } catch (e) {
       throw("Ocurrió un error desconocido iniciación sesión, por favor intente más tarde.");
    }
    return null;
  }
}