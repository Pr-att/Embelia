import 'package:embelia/routes/router.dart';
import 'package:embelia/screens/home_screen.dart';
import 'package:embelia/screens/initial_screen.dart';
import 'package:embelia/server/mongoDB.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'authentication/user_auth.dart';

GoogleSignIn _googleSignIn = GoogleSignIn();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("Initializing Firebase...");
  await Firebase.initializeApp();
  print("Firebase Initialized");
  // await MongoDB.connect();
  // await LocalAuth.authenticate();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => UserAuth(
          googleSignIn: _googleSignIn,
        ),
      ),
    ],
    child: const MyApp(),
  ));
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // final user = _googleSignIn.currentUser?.displayName;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: MyRouter.generateRoute,
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      // initialRoute: user != null ? HomeScreen.id : InitialScreen.id,
      // home: const SignInScreen(),
      initialRoute: InitialScreen.id,
    );
  }
}
