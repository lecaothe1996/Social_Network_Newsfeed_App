import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:social_app/login/views/login_page.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/welcome/auth/gmail_login.dart';
import 'package:social_app/welcome/blocs/auth_bloc.dart';

import '../../blocs/app_state_bloc.dart';
import '../../themes/app_color.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/icon_button_widget.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  AppStateBloc get appStateBloc => Provider.of<AppStateBloc>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    // print('Build WelcomePage===================');
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssetBackgrounds.welcome),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: Gradients.defaultGradientBackground,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Find new friends nearby',
                          style: AppTextStyles.h1,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 14, bottom: 22),
                          child: Text(
                            'With millions of users all over the world, we gives you the ability to connect with people no matter where you are.',
                            style: AppTextStyles.h5,
                          ),
                        ),
                        MyElevatedButton(
                          primary: AppColors.white,
                          text: 'Log In',
                          textColor: AppColors.textLogin,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 48),
                          child: MyElevatedButton(
                            text: 'Sign Up',
                            onPressed: () {
                              AuthGmail().getPhotos();
                            },
                          ),
                        ),
                        Text(
                          'Or log in with',
                          style: AppTextStyles.h6.copyWith(color: AppColors.slate),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18, bottom: 54),
                          child: BlocListener<AuthBloc, AuthState>(
                            listener: (context, state) {
                              if (state is AuthSuccess) {
                                appStateBloc.changeAppState(AppState.authorized);
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyIconButton(
                                  nameImage: AppAssetIcons.facebook,
                                  onTap: () {
                                    print('Click facebook');
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 13),
                                  child: MyIconButton(
                                    nameImage: AppAssetIcons.twitter,
                                    onTap: () {
                                      print('Click twitter');
                                    },
                                  ),
                                ),
                                MyIconButton(
                                  nameImage: AppAssetIcons.google,
                                  onTap: () {
                                    print('Click google');
                                    context.read<AuthBloc>().add(LogInGmail());
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
