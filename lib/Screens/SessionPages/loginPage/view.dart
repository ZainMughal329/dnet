// import 'package:d_net/Utilities/ReusableComponents/utilis.dart';
// import 'package:d_net/Utilities/services/shared_pref_services.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../Utilities/Routes/routesNames.dart';
// import 'controller.dart';
//
// class LoginScreen extends GetView<loginController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Log In'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextFormField(
//               controller: controller.state.emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//               keyboardType: TextInputType.emailAddress,
//             ),
//             SizedBox(height: 16.0),
//             TextFormField(
//               controller: controller.state.passController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: false,
//             ),
//             SizedBox(height: 24.0),
//             Obx((){
//               return ElevatedButton(
//                 onPressed: () {
//                   if (controller.state.emailController.text ==
//                       "rehandreamnet@gmail.com" &&
//                       controller.state.passController.text == "rehan@123") {
//                     sharedPrefrences().setAdminLogin(true).then((value){
//                       print("Setted true");
//                       Utils.showToast("Admin Login Successfull");
//                       Get.offAllNamed(RoutesNames.adminScreen);
//                     }).onError((error, stackTrace){
//
//                       Utils.showToast("Error While Login");
//                       Get.to(LoginScreen());
//                     });
//
//                   } else {
//                     controller.handleLogin(controller.state.emailController.text.trim().toString(),
//                         controller.state.passController.text.trim().toString());
//                   }
//                 },
//                 child: controller.state.loading.value==true ? Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.white,
//                   ),
//                 ) : Center(child: Text('Log In')),
//               );
//             }),
//             SizedBox(height: 16.0),
//             TextButton(
//               onPressed: () {
//                 Get.toNamed(RoutesNames.signUpScreen);
//               },
//               child: Text('Don\'t have an account? Sign Up'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../../Utilities/ReusableComponents/background.dart';
import 'components/form.dart';
import 'components/image.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: const MobileLoginScreen(),

      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LoginScreenTopImage(),
          Row(
            children: [
              Spacer(),
              Expanded(
                flex: 8,
                child: LoginForm(),
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}


