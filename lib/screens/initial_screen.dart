import 'dart:ui';

import 'package:embelia/buttons/elevated_button/text_input.dart';
import 'package:embelia/localStorage/local_storage.dart';
import 'package:embelia/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../authentication/user_auth.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    // TODO: implement initState
    UserAuth().checkLogin().then(
      (value) {
        if (value == true) {
          GoRouter.of(context).goNamed(MyAppRouteConstants.homeScreen);
        } else {
          if (LocalStorage.getString('email') != null) {
            GoRouter.of(context).goNamed(MyAppRouteConstants.homeScreen);
          }
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Stack(
          children: [
            Container(
              height: screenHeight,
              width: screenWidth,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/soothing_background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            Center(
              child: Container(
                height: screenHeight / 2,
                width: screenWidth / 1.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.6),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const InputTextButton(), // Email-Password Sign In
                    const SizedBox(
                      height: 10,
                    ),
                    IconButton(
                      icon: Image.asset(
                        'assets/images/google_icon.png',
                        height: 40,
                        width: 50,
                      ),
                      onPressed: () async {
                        showProgress(context);
                        try {
                          UserAuth.signInWithGoogle().then(
                            (value) async {
                              await LocalStorage.setString(
                                      'email', UserAuth.userEmail)
                                  .then(
                                (value) => LocalStorage.setString(
                                        'name', UserAuth.userName)
                                    .then(
                                  (value) {
                                    Navigator.pop(context);
                                    GoRouter.of(context).goNamed(
                                        MyAppRouteConstants.homeScreen);
                                  },
                                ),
                              );
                            },
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                e.toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    const Text('Sign In with Google'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
