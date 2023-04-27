import 'dart:ui';
import 'package:embelia/buttons/elevated_button/text_input.dart';
import 'package:embelia/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../authentication/user_auth.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);
  static const String id = "InitialScreen";

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    final ScreenHeight = MediaQuery.of(context).size.height;
    final ScreenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [
              Container(
                height: ScreenHeight,
                width: ScreenWidth,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/happy.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: ScreenHeight / 1.5,
                  width: ScreenWidth / 1.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withOpacity(0.8),
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
                          height: 20,
                          width: 30,
                        ), onPressed: () {
                        context.read<UserAuth>().signInWithGoogle().then((value) {
                          if (value != null) {
                            Navigator.pushNamed(context, HomeScreen.id);
                          }
                        });
                      },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
