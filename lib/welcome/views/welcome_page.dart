import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../widgets/button_widget.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff242A37), Colors.transparent],
                stops: [0.1, 0.9]).createShader(rect);
          },
          blendMode: BlendMode.dstIn,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backgrounds/bg_welcome.png'),
                fit: BoxFit.cover,
              ),
            ),
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
                    style: TextStyle(fontSize: 44, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 14, bottom: 22),
                    child: Text(
                      'With milions of users all over the world, we gives you the ability to connect with people no matter where you are.',
                      style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w200),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xffFF2D55),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 48),
                    child: SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: MyElevatedButton(
                          width: double.infinity,
                          onPressed: () {},
                          borderRadius: BorderRadius.circular(100),
                          child: const Text('Sign Up'),
                        )),
                  ),
                  const Text(
                    'Or log in with',
                    style: TextStyle(fontSize: 13, color: Color(0xff4E586E)),
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
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/images/icons/ic_twitter.png',
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _signInWithGoogle();
                          },
                          icon: Image.asset(
                            'assets/images/icons/ic_google_plus.png',
                            color: Colors.white,
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
