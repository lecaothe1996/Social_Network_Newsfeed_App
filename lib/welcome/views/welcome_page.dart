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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Find new friends nearby',
                    style: TextStyle(fontSize: 44, color: AppColors.white, fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 14, bottom: 22),
                    child: Text(
                      'With milions of users all over the world, we gives you the ability to connect with people no matter where you are.',
                      style: TextStyle(fontSize: 17, color: AppColors.white),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.white,
                        onPrimary: AppColors.slate,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: const Text(
                        'Log In',
                        style: TextStyle(fontSize: 15, color: AppColors.textLogin, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 48),
                    child: SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: MyElevatedButton(onPressed: () {}, text: 'Sign Up')
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
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/images/icons/ic_facebook.png',
                            color: AppColors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/images/icons/ic_twitter.png',
                            color: AppColors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _signInWithGoogle();
                          },
                          icon: Image.asset(
                            'assets/images/icons/ic_google_plus.png',
                            color: AppColors.white,
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

  Future<UserCredential> _signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    print('accessToken= ${googleAuth?.accessToken}');

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    final AuthenAccount = await FirebaseAuth.instance.signInWithCredential(credential);

    print('AuthenAccount= ${AuthenAccount}');

    return AuthenAccount;
  }
}
