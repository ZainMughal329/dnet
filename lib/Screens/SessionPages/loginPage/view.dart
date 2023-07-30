import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utilities/Routes/routesNames.dart';
import 'controller.dart';

class LoginScreen extends GetView<loginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: controller.state.emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: controller.state.passController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                if (controller.state.emailController.text ==
                        "rehandreamnet@gmail.com" &&
                    controller.state.passController.text == "rehan@123") {
                  Get.toNamed(RoutesNames.adminScreen);
                } else {
                  controller.handleLogin(controller.state.emailController.text,
                      controller.state.passController.text);
                }
              },
              child: Text('Log In'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Get.toNamed(RoutesNames.signUpScreen);
              },
              child: Text('Don\'t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
