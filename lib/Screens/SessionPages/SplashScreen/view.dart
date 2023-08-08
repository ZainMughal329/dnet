import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:d_net/Screens/SessionPages/SplashScreen/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // controller.chkNotifications();
    controller.checkLogin();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo1.png',
            // height: 300,
            ), // Put your logo here
            SizedBox(height: 20),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText('Dubai Sky Net',
                    speed: Duration(milliseconds: 200),

                    textStyle: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold)
                ),
              ],
              // pause: Duration(seconds: 5),
              // displayFullTextOnTap: true,
              // stopPauseOnTap: true,
            ),
          ],
        ),
      ),
    );
  }
}
