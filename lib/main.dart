import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase/firebase_initializer.dart';
import 'my_app/my_app.dart';
import 'utils/shared_preference_util.dart';
import 'welcome/blocs/auth_bloc.dart';
import 'welcome/views/welcome_page.dart';

void main() async {
  // statusBar transparent
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: AppColors.transparent));
  // initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // initialize SharedPreferences
  await SharedPreferenceUtil.init();

  // await Future.delayed(Duration(seconds: 10));
  runApp(
    const MyApp(),
  );
}
