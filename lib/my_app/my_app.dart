import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:social_app/my_app/app_state_bloc.dart';
import 'package:social_app/pages/home/blocs/post_bloc/post_bloc.dart';
import 'package:social_app/pages/pages.dart';
import 'package:social_app/pages/user_profile/blocs/user_photos/user_photos_cubit.dart';
import 'package:social_app/pages/user_profile/blocs/user_posts/user_posts_cubit.dart';
import 'package:social_app/pages/user_profile/blocs/user_profile/user_profile_cubit.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_fonts.dart';
import 'package:social_app/welcome/blocs/auth_bloc.dart';
import 'package:social_app/welcome/views/welcome_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appStateBloc = AppStateBloc();

  @override
  void dispose() {
    _appStateBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: AppColors.dark,
          titleSpacing: 0,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(bodyColor: AppColors.white),
        fontFamily: FontFamily.arial,
        scaffoldBackgroundColor: AppColors.dark,
      ),
      home: Provider<AppStateBloc>(
        create: (context) => _appStateBloc,
        child: StreamBuilder<AppState>(
          stream: _appStateBloc.appState,
          initialData: _appStateBloc.initState,
          builder: (context, snapshot) {
            // print('⚡️ snapshot===${snapshot.data}');
            if (snapshot.data == AppState.loading) {
              // print('⚡️ loading splash===');
            }
            if (snapshot.data == AppState.unAuthorized) {
              return BlocProvider(
                create: (context) => AuthBloc(),
                child: const WelcomePage(),
              );
            }
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => UserPostsCubit()),
                BlocProvider(create: (_) => UserPhotosCubit()),
                BlocProvider(create: (_) => UserProfileCubit()),
                BlocProvider(
                  create: (context) => PostBloc(userPostsCubit: BlocProvider.of<UserPostsCubit>(context))
                    ..add(
                      LoadPosts(),
                    ),
                  child: const Pages(),
                ),
              ],
              child: const Pages(),
            );
          },
        ),
      ),
    );
  }
}
