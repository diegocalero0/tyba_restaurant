import 'package:firebase_auth/firebase_auth.dart';
import 'package:tyba_great_app/base/service_locator.dart';

class CreateUserUseCase {

  final FirebaseAuth _firebaseAuthInstance;

  CreateUserUseCase({
    FirebaseAuth? firebaseAuthInstance
  }): _firebaseAuthInstance = firebaseAuthInstance ?? locator.get<FirebaseAuth>();

  Future<UserCredential?> invoke(String email, String password) async {
    try {
      final credential = await _firebaseAuthInstance
      .createUserWithEmailAndPassword(email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw("La contraseña es muy débil, por favor intente con otra más fuerte.");
      } else if (e.code == 'email-already-in-use') {
        throw("El correo electrónico ingresado ya se encuentra registrado.");
      }
    } catch (e) {
       throw("Ocurrió un error desconocido creando al usuario, por favor intente más tarde.");
    }
    return null;
  }
}