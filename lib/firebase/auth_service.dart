import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User?> createAccountWithEmailAndPassword(
    String email,
    String password,
    String userName,
  ) async {
    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((credential) async {
          await credential.user?.updateDisplayName(userName);
        });

    return firebaseAuth.currentUser;
  }

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  return firebaseAuth.currentUser;
  }
}
