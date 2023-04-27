import 'package:embelia/screens/faq.dart';
import 'package:embelia/screens/home_screen.dart';
import 'package:embelia/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import '../screens/initial_screen.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.id:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case InitialScreen.id:
        return MaterialPageRoute(builder: (_) => const InitialScreen());
      case FAQ.id:
        return MaterialPageRoute(builder: (_) => const FAQ());
      case SignInScreen.id:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
