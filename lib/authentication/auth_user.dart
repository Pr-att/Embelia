import 'package:embelia/authentication/user_data_constants.dart';
import 'package:embelia/server/server.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

bool isLoggedIn = false;

class UserAuth with ChangeNotifier {
  var user;
  var userPhotoUrl;
  var tempGoogleIDName;
  var tempGoogleIDEmail;
  static String id = "UserAuth";

  final GoogleSignIn _googleSignIn;
  UserAuth({required GoogleSignIn googleSignIn}) : _googleSignIn = googleSignIn;
  signInWithGoogle() async {
    try {
      user = await _googleSignIn.signIn();
      if (user != null) {
        tempGoogleIDName = user.displayName;
        tempGoogleIDEmail = user.email;
        isLoggedIn = true;
        kUserEmail = user.email;
        kUserName = user.displayName;
        kUserPhotoUrl = user.photoUrl;
        userPhotoUrl = user.photoUrl;
        kUserGoogleID = user.id;
        notifyListeners();
      }

      return isLoggedIn;
    } catch (e) {
      return e;
    }
  }

  checkLogin() async {
    return await _googleSignIn.isSignedIn();
  }

  signOutFromGoogle() async {
    user = await _googleSignIn.isSignedIn();
    if (user) {
      await _googleSignIn.signOut();
      isLoggedIn = false;
      kUserGoogleID = null;
      kUserPhotoUrl = null;
      userPhotoUrl = null;
      kUserEmail = null;
      kUserGoogleID = null;
      kUserName = null;
      notifyListeners();
    }
  }
}

showProgress(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      });
}

checkLog() async {
  var user = await UserAuth(googleSignIn: googleSignIn).checkLogin();
  if (user) {
    return true;
  } else {
    return false;
  }
}


