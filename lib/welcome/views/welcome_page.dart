import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_app/login/views/login_page.dart';
import 'package:social_app/themes/app_color.dart';

import '../../themes/app_color.dart';
import '../../widgets/button_widget.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/backgrounds/bg_welcome.png'),
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
                          style: TextStyle(
                              fontSize: 44,
                              fontWeight: FontWeight.bold),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 14, bottom: 22),
                          child: Text(
                            'With millions of users all over the world, we gives you the ability to connect with people no matter where you are.',
                            style: TextStyle(
                                fontSize: 17,
                            ),
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
                            onPressed: () {},
                          ),
                        ),
                        const Text(
                          'Or log in with',
                          style: TextStyle(fontSize: 13, color: AppColors.slate),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18, bottom: 54),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Text('data'),
                                onTap: () {},
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                  'assets/images/icons/ic_twitter.png',
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _signInWithGoogle();
                                },
                                icon: Image.asset(
                                  'assets/images/icons/ic_google_plus.png',
                                ),
                              ),
                            ],
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

  Future<void> _signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    print('gmail_token=${googleAuth?.accessToken}');

    // Post gmail_token to server
    try {
      if (googleAuth?.accessToken != null) {
        final dio = Dio(BaseOptions(baseUrl: 'https://api.dofhunt.200lab.io'));
        final authResponce = await dio.post('/v1/auth/gmail', data: {'gmail_token': googleAuth?.accessToken});
        print('authResponce=$authResponce');

        // Get access_token form
        if (authResponce.statusCode == 200) {
          final accessToken = authResponce.data['data']['access_token'];
          print('accessToken=$accessToken');
        } else {
          print('Error Signin with google');
        }
      }
    } catch (error) {
      print('error=$error');
    }
  }
}
