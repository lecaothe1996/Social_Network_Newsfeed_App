import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_fonts.dart';

import 'firebase/firebase_initializer.dart';
import 'splash_page.dart';
import 'utils/preference_utils.dart';
import 'welcome/blocs/auth_bloc.dart';
import 'welcome/views/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
// await Future.delayed(Duration(seconds: 10));
  // initialize SharedPreferences
  await PreferenceUtils.init();
  // statusBar transparent
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(
    const FirebaseInitializer(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: AppColors.dark,
          elevation: 0,
          centerTitle: true,
        ),
        textTheme: const TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(bodyColor: AppColors.white),
        fontFamily: FontFamily.avenir,
        scaffoldBackgroundColor: AppColors.dark,
      ),
      home: const SplashPage(),
    );
  }
}
