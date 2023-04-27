import 'package:embelia/authentication/user_data.dart';
import 'package:embelia/server/server.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class UserAuth with ChangeNotifier {
  var user;
  var userPhotoUrl;
  var name;
  var tempGoogleIDEmail;
  static String id = "UserAuth";

  final GoogleSignIn _googleSignIn;
  UserAuth({required GoogleSignIn googleSignIn}) : _googleSignIn = googleSignIn;

  signInWithGoogle() async {
    try {
      user = await _googleSignIn.signIn();
      if (user != null) {
        name = user.displayName;
        tempGoogleIDEmail = user.email;
        userPhotoUrl = user.photoUrl;
        notifyListeners();
        return user.email;
      }
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
      userPhotoUrl = null;
      notifyListeners();
    }
  }

// signUpWithGoogle(BuildContext context) async {
//   final provider = Provider.of<UserAuth>(context, listen: false);
//   await provider.signInWithGoogle();
//   if (provider.user != null) {
//     await _googleSignIn.(
//       provider.user!.email,
//       provider.user!.displayName,
//       provider.user!.photoUrl,
//       provider.user!.id,
//     );
//     Navigator.pop(context);
//     Navigator.pushNamed(context, '/home');
//   } else {
//     Navigator.pop(context);
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Sign in failed'),
//       ),
//     );
//   }
// }
}

showProgress(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      });
}
