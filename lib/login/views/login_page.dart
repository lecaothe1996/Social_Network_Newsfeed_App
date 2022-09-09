import 'package:flutter/material.dart';
import 'package:social_app/widgets/textfield_widget.dart';

import '../../themes/app_color.dart';
import '../../widgets/button_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/backgrounds/bg_login.png'),
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
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome back',
                        style: TextStyle(fontSize: 34, color: AppColors.white, fontWeight: FontWeight.bold),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 12, bottom: 58),
                        child: Text(
                          'Login to your account',
                          style: TextStyle(fontSize: 17, color: AppColors.white),
                        ),
                      ),
                      const MyTextField(hintText: 'Email'),
                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 40),
                        child: MyTextField(hintText: 'Password'),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: MyElevatedButton(onPressed: () {}, text: 'LOGIN'),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 53, bottom: 27),
                        alignment: Alignment.center,
                        child: const Text('Forgot your password?', style: TextStyle(fontSize: 17, color: AppColors.white)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
