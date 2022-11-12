import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/utils/preference_utils.dart';

import '../blocs/app_state_bloc.dart';
import '../themes/app_assets.dart';
import '../themes/app_text_styles.dart';
import 'home/view/home_screen.dart';

class Pages extends StatefulWidget {
  const Pages({Key? key}) : super(key: key);

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const HomeScreen(),
          Container(color: Colors.green),
          Container(color: Colors.amber),
          Container(color: Colors.tealAccent),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.black,
        unselectedItemColor: AppColors.slate,
        selectedItemColor: AppColors.redMedium,
        selectedLabelStyle: AppTextStyles.h6,
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
