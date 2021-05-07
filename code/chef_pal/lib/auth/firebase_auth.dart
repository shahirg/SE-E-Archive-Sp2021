// written by: Malak, Malena, Shahir 
// tested by: Aswathy
// debugged by: Shahir
// Authentification Logic

import 'package:chef_pal/ingredient_selection/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthentificationService {
  final FirebaseAuth _firebaseAuth;

  AuthentificationService(this._firebaseAuth);

  // Creates a User Stream
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  // Signs out user
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Signs in user
  Future<String> signIn(String email, String password) async {
    print(email.toString());
    print(password);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Signed In");
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Signs up user
  Future<String> signUp(String username, String email, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("hi");
      await FirestoreService(user.user.uid).initUser(username);

      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password prvided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return ('The account already exists for that email.');
      }
      return e.message;
    }
  }
}

// Future<bool> signIn(String email, String password) async {
//   try {
//     await FirebaseAuth.instance
//         .signInWithEmailAndPassword(email: email, password: password);
//     return true;
//   } catch (e) {
//     print(e);
//     return false;
//   }
// }

// Future<bool> register(String email, String password) async {
//   try {
//     await FirebaseAuth.instance.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     return true;
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'weak-password') {
//       print('The password prvided is too weak.');
//     } else if (e.code == 'email-already-in-use') {
//       print('The account already exists for that email.');
//     }
//     return false;
//   } catch (e) {
//     print(e.toString());
//     return false;
//   }
// }
