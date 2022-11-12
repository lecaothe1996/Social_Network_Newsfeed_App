import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_fonts.dart';

import 'firebase/firebase_initializer.dart';
import 'my_app.dart';
import 'utils/preference_utils.dart';
import 'welcome/blocs/auth_bloc.dart';
import 'welcome/views/welcome_page.dart';

void main() async {
  // statusBar transparent
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: AppColors.transparent));
  // initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // initialize SharedPreferences
  await PreferenceUtils.init();

  // await Future.delayed(Duration(seconds: 10));
  runApp(
    const MyApp(),
  );
}
