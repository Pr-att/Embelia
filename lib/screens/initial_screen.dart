import 'package:embelia/buttons/elevated_button/text_input.dart';
import 'package:embelia/constants.dart';
import 'package:embelia/screens/home_screen.dart';
import 'package:embelia/screens/sign_in_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../authentication/auth_user.dart';
import '../authentication/user_data_constants.dart';
import '../buttons/elevated_button/elevated_button.dart';
import 'registration_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);
  static const String id = "InitialScreen";

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  @override
  initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    // Add Here the thing u want to call when the widget is called
  }

  GoogleSignIn googleSignIn = GoogleSignIn();

  signInWithGoogle() {
    return UserAuth(googleSignIn: googleSignIn).signInWithGoogle();
  }

  signOutFromGoogle() {
    return UserAuth(googleSignIn: googleSignIn).signOutFromGoogle();
  }

  double radiusValue = 70;

  @override
  Widget build(BuildContext context) {
    ScreenHeight = MediaQuery.of(context).size.height;
    ScreenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 233, 233, 229),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: ScreenHeight * 0.45),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: kGradient,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                  ),
                ),
              ),
            ),
            Lottie.asset("assets/asset/starFall.json", repeat: true),
            Center(
              child: Hero(
                tag: 'logo',
                child: GestureDetector(
                  onLongPress: () {
                    if (radiusValue == 70) {
                      setState(() {
                        radiusValue = 90;
                      });
                    } else {
                      setState(() {
                        radiusValue = 70;
                      });
                    }
                  },
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: radiusValue,
                      child: Image.asset(
                        "assets/asset/google_icon.png",
                      )),
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: ScreenHeight * 0.65),
                    child: CustomElevatedButton(
                      myFunc: () {
                        Navigator.pushReplacementNamed(
                            context, SignInScreen.id);
                      },
                      myText: 'Sign in with Email',
                      icon: const Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomElevatedButton(
                      myFunc: () async {
                        showProgress(context);
                        isSignIn =
                            await context.read<UserAuth>().signInWithGoogle();
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();

                        if (isSignIn) {
                          if (readData(
                                  context.read<UserAuth>().tempGoogleIDEmail) !=
                              null) {
                            if (getPassByKey(
                                context.read<UserAuth>().tempGoogleIDEmail) != null ) {
                              Navigator.pushReplacementNamed(
                                  context, HomeScreen.id);
                            } else {
                              Navigator.pushNamed(context, RegistrationScreen.id);
                            }
                          }
                        }
                      },
                      myText: "Sign in with Google",
                      icon: Image.asset(
                        "assets/asset/google_icon.png",
                        height: 20,
                        width: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
