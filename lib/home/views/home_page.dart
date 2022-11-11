import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:social_app/blocs/bloc_provider.dart';
import 'package:social_app/utils/preference_utils.dart';

import '../../blocs/app_state_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppStateBloc get appStateBloc => Provider.of<AppStateBloc>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () {
              PreferenceUtils.clear();
              appStateBloc.changeAppState(AppState.unAuthorized);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
