import 'package:d_net/Screens/SessionPages/loginPage/controller.dart';
import 'package:d_net/Utilities/Routes/routesNames.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Utilities/ReusableComponents/already_have_an_account_acheck.dart';
import '../../../../Utilities/ReusableComponents/constants.dart';
import '../../../../Utilities/ReusableComponents/utilis.dart';
import '../../../../Utilities/services/shared_pref_services.dart';
import '../view.dart';

class LoginForm extends GetView<loginController> {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: controller.state.emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: controller.state.passController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: Obx(
              () => ElevatedButton(
                onPressed: () {
                  if (controller.state.emailController.text.trim().toString() ==
                          "rehandreamnet@gmail.com" &&
                      controller.state.passController.text.trim().toString() == "rehan@123") {
                    controller.setLoading(true);
                    sharedPrefrences().setAdminLogin(true).then((value) {
                      controller.setLoading(false);
                      print("Setted true");
                      Utils.showToast("Admin Login Successfull");
                      Get.offAllNamed(RoutesNames.adminScreen);
                    }).onError((error, stackTrace) {
                      controller.setLoading(false);
                      Utils.showToast("Error While Login");
                      Get.to(LoginScreen());
                    });
                  } else {
                    controller.setLoading(false);
                    controller.handleLogin(
                        controller.state.emailController.text.trim().toString(),
                        controller.state.passController.text.trim().toString());
                  }
                },
                child: controller.state.loading.value == true
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Center(
                        child: Text(
                          'Log In'.toUpperCase(),
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Get.toNamed(RoutesNames.signUpScreen);
            },
          ),
        ],
      ),
    );
  }
}
