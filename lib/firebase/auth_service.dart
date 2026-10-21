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
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await credential.user?.updateDisplayName(userName);
    return credential.user;
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

    final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    return await firebaseAuth.signInWithCredential(credential);
  }
}
