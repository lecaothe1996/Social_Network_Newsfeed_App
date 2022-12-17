import 'package:flutter/material.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/widgets/button_widget.dart';
import 'package:social_app/widgets/icon_button_widget.dart';
import 'package:social_app/widgets/text_field_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailCtl = TextEditingController();
    final passCtl = TextEditingController();

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssetBackgrounds.login),
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
            leading: MyIconButton(
              nameImage: AppAssetIcons.arrowLeft,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome back',
                        style: AppTextStyles.h2,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 12, bottom: 58),
                        child: Text(
                          'Login to your account',
                          style: AppTextStyles.h5,
                        ),
                      ),
                      MyTextField(
                        controller: emailCtl,
                        hintText: 'Email',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 40),
                        child: MyTextField(
                          controller: passCtl,
                          hintText: 'Password',
                        ),
                      ),
                      MyElevatedButton(
                        width: double.infinity,
                        text: 'Log In',
                        onPressed: () {},
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 53, bottom: 54),
                        alignment: Alignment.center,
                        child: const Text('Forgot your password?', style: AppTextStyles.h5),
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
