import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:social_app/pages/home/blocs/home_feed_bloc.dart';

import 'blocs/app_state_bloc.dart';
import 'pages/pages.dart';
import 'themes/app_color.dart';
import 'themes/app_fonts.dart';
import 'welcome/blocs/auth_bloc.dart';
import 'welcome/views/welcome_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _SplashPageState();
}

class _SplashPageState extends State<MyApp> {
  final appStateBloc = AppStateBloc();

  @override
  void dispose() {
    appStateBloc.dispose();
    super.dispose();
  }

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
      home: Provider<AppStateBloc>(
        create: (context) => appStateBloc,
        child: StreamBuilder<AppState>(
          stream: appStateBloc.appState,
          initialData: appStateBloc.initState,
          builder: (context, snapshot) {
            // print('⚡️ snapshot===${snapshot.data}');
            if (snapshot.data == AppState.loading) {
              return Container(
                color: Colors.blue,
              );
            }
            if (snapshot.data == AppState.unAuthorized) {
              return BlocProvider(
                create: (context) => AuthBloc(),
                child: const WelcomePage(),
              );
            }
            return BlocProvider(
              create: (context) => HomeFeedBloc()..add(LoadHomeFeeds()),
              child: const Pages(),
            );
          },
        ),
      ),
    );
  }
}
