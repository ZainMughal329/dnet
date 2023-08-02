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
      body: SafeArea(
        child: Center(
          child: Center(
            child: Text("SplashScreen"),
          ),
        ),
      ),
    );
  }
}
