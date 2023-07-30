import 'package:d_net/Screens/SessionPages/signUpPage/state.dart';
import 'package:d_net/Utilities/Routes/routesNames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final state = SignState();
  SignInController();
  final auth = FirebaseAuth.instance;

  void handleSignIn(String email , password) async{
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
        Get.toNamed(RoutesNames.userScreen);
      }).onError((error, stackTrace) {
        print('Error');
      });
    }catch (e) {
      print('Exception occurs');
    }

}
}