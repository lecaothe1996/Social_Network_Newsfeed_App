import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:social_app/blocs/bloc_provider.dart';
import 'package:social_app/home/views/home_page.dart';

import 'blocs/app_state_bloc.dart';
import 'welcome/blocs/auth_bloc.dart';
import 'welcome/views/welcome_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final appStateBloc = AppStateBloc();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppStateBloc>(
      create: (context) => appStateBloc,
      child: StreamBuilder<AppState>(
        stream: appStateBloc.appState,
        initialData: appStateBloc.initState,
        builder: (context, snapshot) {
          print('⚡  snapshot===${snapshot.data}');
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
          return const HomePage();
        },
      ),
    );
  }
}
