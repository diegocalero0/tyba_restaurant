import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tyba_great_app/use_cases/create_user_use_case.dart';

import 'create_user_use_case_test.mocks.dart';



@GenerateMocks([FirebaseAuth, UserCredential])
void main() {

  final MockFirebaseAuth _mockFirebaseAuth = MockFirebaseAuth();
  final MockUserCredential _mockUserCredential = MockUserCredential();

  group("Invoke", () {
    test("Invoke success", () async {
      final CreateUserUseCase createUserUseCase = CreateUserUseCase(firebaseAuthInstance: _mockFirebaseAuth);
      String email = "diegoacalero0@gmail.com";
      String password = "Asdf1234*";
      when(_mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).thenAnswer((realInvocation) => Future.value(_mockUserCredential));
      final result = await createUserUseCase.invoke(email, password);
      expect(result, _mockUserCredential);
    });

    test("Invoke weak password", () async {
      final CreateUserUseCase createUserUseCase = CreateUserUseCase(firebaseAuthInstance: _mockFirebaseAuth);
      String email = "diegoacalero0@gmail.com";
      String password = "Asdf1234*";
      when(_mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).thenThrow(FirebaseAuthException(code: "weak-password"));
      
      try {
        final result = await createUserUseCase.invoke(email, password);
      } catch(e) {
        expect(e.toString(), "La contraseña es muy débil, por favor intente con otra más fuerte.");
      }
    });

    test("Invoke password already in use", () async {
      final CreateUserUseCase createUserUseCase = CreateUserUseCase(firebaseAuthInstance: _mockFirebaseAuth);
      String email = "diegoacalero0@gmail.com";
      String password = "Asdf1234*";
      when(_mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).thenThrow(FirebaseAuthException(code: "email-already-in-use"));
      
      try {
        final result = await createUserUseCase.invoke(email, password);
      } catch(e) {
        expect(e.toString(), "El correo electrónico ingresado ya se encuentra registrado.");
      }
    });
  });

}