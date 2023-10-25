import 'package:embelia/localStorage/local_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../routes/router.dart';

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

  Future signInUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context,
      required String name}) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      await LocalStorage.setString('email', email).then((value) async =>
          await LocalStorage.setString('name', name).then((value) async =>
              GoRouter.of(context).goNamed(MyAppRouteConstants.homeScreen)));
    }).catchError(
      (e) async {
        switch (e.code) {
          case 'user-not-found':
            await _auth
                .createUserWithEmailAndPassword(
                    email: email, password: password)
                .then((value) async {
              await LocalStorage.setString('email', email).then((value) async =>
                  await LocalStorage.setString('name', name).then(
                      (value) async => GoRouter.of(context)
                          .goNamed(MyAppRouteConstants.homeScreen)));
            });
          case 'wrong-password':
            return e.code;
          default:
            return e.code;
        }
        return e.code;
      },
    );
  }
}

showProgress(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return const Center(child: CircularProgressIndicator());
    },
  );
}
