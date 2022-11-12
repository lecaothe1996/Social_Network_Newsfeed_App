import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/themes/app_assets.dart';

import '../../../blocs/app_state_bloc.dart';
import '../../../themes/app_text_styles.dart';
import '../../../widgets/text_field_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppStateBloc get appStateBloc => Provider.of<AppStateBloc>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyTextField(
          hintText: 'Search',
        ),
        actions: [
          IconButton(
            onPressed: () {
              appStateBloc.logout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        color: Colors.purpleAccent,
      ),
    );
  }
}
