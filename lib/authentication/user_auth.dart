import 'package:embelia/localStorage/local_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static String id = "UserAuth";
  static GoogleSignInAccount? _user;

  static dynamic get userEmail =>
      _user?.email ?? LocalStorage.getString('email');

  static dynamic get userName =>
      _user?.displayName ?? LocalStorage.getString('name');

  set user(GoogleSignInAccount? user) {
    _user = user;
  }

  static GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  static signInWithGoogle() async {
    try {
      _user = await googleSignIn.signIn();
    } catch (e) {
      return e;
    }
  }

  Future<bool> checkLogin() async => await googleSignIn.isSignedIn();

  Future signOutFromGoogle() async {
    if (await checkLogin()) {
      await googleSignIn.signOut();
    }
  }
}
