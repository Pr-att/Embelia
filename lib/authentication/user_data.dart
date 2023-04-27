import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:embelia/authentication/user_data_schema.dart';
import 'package:provider/provider.dart';
import 'user_auth.dart';

var healthScore;
var totalTask;
var streak;
var prizeMoney;

class UserData with ChangeNotifier {

  final videos = FirebaseFirestore.instance.collection('users');

  Future userDataUpdate(BuildContext context) async {

    final userData = UserDataSchema(
        email: context.read<UserAuth>().tempGoogleIDEmail,
        healthScore: healthScore,
        totalTask: totalTask,
        streak: streak,
        prizeMoney: prizeMoney
    );

    final json = userData.toMap();
    try {
      await videos.doc(context.read<UserAuth>().tempGoogleIDEmail).update(json);
    } catch (e) {
      await videos.doc(context.read<UserAuth>().tempGoogleIDEmail).set(json);
    }
    notifyListeners();
  }

  Future createUserData(BuildContext context) async {

    final userData = UserDataSchema(
        email: context.read<UserAuth>().tempGoogleIDEmail,
        healthScore: 0,
        totalTask: 0,
        streak: 0,
        prizeMoney: 0
    );

    final json = userData.toMap();
      await videos.doc(context.read<UserAuth>().tempGoogleIDEmail).set(json);
    notifyListeners();
  }


  Future getUserData(BuildContext context) async {

    DocumentSnapshot snapshot = await videos.doc(context.read<UserAuth>().tempGoogleIDEmail).get();
    if (snapshot.exists) {
      healthScore = snapshot['healthScore'];
      totalTask = snapshot['totalTask'];
      streak = snapshot['streak'];
      prizeMoney = snapshot['prizeMoney'];
    } else {
      await createUserData(context);
    }
    notifyListeners();
  }

}
