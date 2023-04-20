import 'package:embelia/authentication/user_biometric.dart';
import 'package:embelia/buttons/elevated_button/text_input.dart';
import 'package:embelia/chat/chat_bot.dart';
import 'package:embelia/routes/router.dart';
import 'package:embelia/screens/faq.dart';
import 'package:embelia/screens/home_screen.dart';
import 'package:embelia/screens/initial_screen.dart';
import 'package:embelia/screens/registration_screen.dart';
import 'package:embelia/screens/sign_in_screen.dart';
import 'package:embelia/screens/splash_screen.dart';
import 'package:embelia/widgets/pallets.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'authentication/auth_user.dart';
import 'authentication/user_data_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var box = await Hive.openBox("LocalDB");
  kLog = await checkLog();
  // await LocalAuth.authenticate();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => UserAuth(
          googleSignIn: GoogleSignIn(),
        ),
      ),
      // ChangeNotifierProvider(
      //   create: (_) => HealthScore(),
      // ),
    ],
    child: const MyApp(),
  ));
}

GoogleSignIn _googleSignIn = GoogleSignIn();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: MyRouter.generateRoute,
      theme: ThemeData.light(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.id,
    );
  }
}
