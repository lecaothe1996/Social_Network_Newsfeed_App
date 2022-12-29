import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:social_app/pages/home/views/home_screen.dart';
import 'package:social_app/pages/user_profile/views/profile_screen.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';

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
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        margin: EdgeInsets.zero,
        itemShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
        selectedItemColor: AppColors.redMedium,
        unselectedItemColor: AppColors.slate,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          SalomonBottomBarItem(
            icon: Image.asset(AppAssetIcons.home, color: AppColors.slate),
            activeIcon: Image.asset(AppAssetIcons.home, color: AppColors.redMedium),
            title: const Text('Home'),
          ),
          SalomonBottomBarItem(
            icon: Image.asset(AppAssetIcons.message, color: AppColors.slate),
            activeIcon: Image.asset(AppAssetIcons.message, color: AppColors.redMedium),
            title: const Text('Messages'),
          ),
          SalomonBottomBarItem(
            icon: Image.asset(AppAssetIcons.notification, color: AppColors.slate),
            activeIcon: Image.asset(AppAssetIcons.notification, color: AppColors.redMedium),
            title: const Text('Notifications'),
          ),
          SalomonBottomBarItem(
            icon: Image.asset(AppAssetIcons.profile, color: AppColors.slate),
            activeIcon: Image.asset(AppAssetIcons.profile, color: AppColors.redMedium),
            title: const Text('Profiles'),
          ),
        ],
      ),
    );
  }
}
