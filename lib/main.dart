import 'package:embelia/localStorage/local_storage.dart';
import 'package:embelia/routes/router.dart';
import 'package:embelia/screens/InitialScreen/auth_init_cubit.dart';
import 'package:embelia/screens/faq/faq_provider_cubit.dart';
import 'package:embelia/screens/homeScreen/auth_cubit.dart';
import 'package:embelia/screens/homeScreen/home_screen_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'authentication/cubit/user_data_firebase_cubit.dart';
import 'authentication/user_biometric.dart';

String? email;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await LocalStorage.init();
  email = prefs.getString("email");
  await Firebase.initializeApp();
  await LocalAuth.authenticate();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LocalStorage(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => FaqProviderCubit(),
          ),
          BlocProvider(
            create: (_) => UserDataFirebaseCubit(),
          ),
          BlocProvider(
            create: (_) => HomeScreenCubit(),
          ),
          BlocProvider(
            create: (_) => AuthCubit(),
          ),
          BlocProvider(
            create: (_) => AuthInitCubit(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
