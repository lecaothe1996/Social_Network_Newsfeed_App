import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_app/themes/app_color.dart';
import 'my_app/my_app.dart';
import 'utils/shared_preference_util.dart';

Future<void> main() async {
  // statusBar transparent
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: AppColors.transparent));
  // initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // initialize SharedPreferences
  await SharedPreferenceUtil.init();
  // Background messages
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await Future.delayed(Duration(seconds: 10));
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('⚡️ Handling a background message ${message.messageId}');
}
