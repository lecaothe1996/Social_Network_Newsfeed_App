import 'package:flutter/material.dart';

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
            ).createShader(rect);
          },
          blendMode: BlendMode.dstIn,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_welcome.png'),
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
                  Text(
                    'Find new friends nearby',
                    style: TextStyle(fontSize: 44, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14, bottom: 22),
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
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xffFF2D55),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)
                        )
                      )
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xffFF2D55),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)
                            )
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
