import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'welcome/blocs/auth_bloc.dart';
import 'welcome/views/welcome_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: BlocProvider(
        create: (context) => AuthBloc(),
        child: const WelcomePage(),
      ),
    );
  }
}
