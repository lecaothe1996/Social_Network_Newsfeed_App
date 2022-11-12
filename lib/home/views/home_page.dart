import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/utils/preference_utils.dart';

import '../../blocs/app_state_bloc.dart';
import '../../themes/app_assets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  AppStateBloc get appStateBloc => Provider.of<AppStateBloc>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () {
              // PreferenceUtils.clear();
              appStateBloc.logout();
              // appStateBloc.changeAppState(AppState.unAuthorized);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Container(color: Colors.white),
          Container(color: Colors.green),
          Container(color: Colors.amber),
          Container(color: Colors.tealAccent),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.black,
        unselectedItemColor: AppColors.slate,
        selectedItemColor: AppColors.redMedium,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(AppAssetIcons.home, color: AppColors.slate),
              activeIcon: Image.asset(AppAssetIcons.home, color: AppColors.redMedium),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Image.asset(AppAssetIcons.message, color: AppColors.slate),
              activeIcon: Image.asset(AppAssetIcons.message, color: AppColors.redMedium),
              label: 'Messages'),
          BottomNavigationBarItem(
              icon: Image.asset(AppAssetIcons.notification, color: AppColors.slate),
              activeIcon: Image.asset(AppAssetIcons.notification, color: AppColors.redMedium),
              label: 'Notifications'),
          BottomNavigationBarItem(
              icon: Image.asset(AppAssetIcons.profile, color: AppColors.slate),
              activeIcon: Image.asset(AppAssetIcons.profile, color: AppColors.redMedium),
              label: 'Profiles'),
        ],
      ),
    );
  }
}
