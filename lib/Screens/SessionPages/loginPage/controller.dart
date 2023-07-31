import 'package:d_net/Screens/SessionPages/loginPage/index.dart';
import 'package:d_net/Utilities/ReusableComponents/utilis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../Utilities/Routes/routesNames.dart';

class loginController extends GetxController {
  final state = loginState();

  loginController();

  final auth = FirebaseAuth.instance;

  void setLoading(bool value){
    state.loading.value = value;
  }

  Future<void> handleLogin(String email, password) async {
    setLoading(true);
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        setLoading(false);
        Utils.showToast("Login Successfully");
        Get.offAllNamed(RoutesNames.userScreen);
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.showToast(error.toString());
        print('Error');
      });
    } catch (e) {
      setLoading(false);
      Utils.showToast(e.toString());
      print('Exception occurs');
    }
  }
}
