import 'package:d_net/Screens/SessionPages/loginPage/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../Utilities/Routes/routesNames.dart';

class loginController extends GetxController {
  final state = loginState();

  loginController();

  final auth = FirebaseAuth.instance;

  Future<void> handleLogin(String email, password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Get.toNamed(RoutesNames.userScreen);
      }).onError((error, stackTrace) {
        print('Error');
      });
    } catch (e) {
      print('Exception occurs');
    }
  }
}
