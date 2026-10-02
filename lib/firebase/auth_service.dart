import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn.instance;

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

  Future<UserCredential> signInWithGoogle() async {
    await googleSignIn.initialize(
      serverClientId:
          "138320424283-6eu2i921rc7i09jt9h6jv65houcm7fnm.apps.googleusercontent.com",
    );

    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await firebaseAuth.signInWithCredential(credential);
  }
}
