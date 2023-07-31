import 'package:d_net/Screens/SessionPages/signUpPage/state.dart';
import 'package:d_net/Utilities/ReusableComponents/utilis.dart';
import 'package:d_net/Utilities/Routes/routesNames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignInController extends GetxController {
  final state = SignState();
  SignInController();
  final auth = FirebaseAuth.instance;

  void setLoading(bool value){
    state.loading.value=value;
  }


  void handleSignIn(String email , password) async{
    setLoading(true);
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
        setLoading(false);
        Utils.showToast('Account Created');
        Get.offAllNamed(RoutesNames.userScreen);
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.showToast('Error Occurred :'+error.toString());
        print('Error');
      });
    }catch (e) {
      setLoading(false);
      Utils.showToast('Error Occurred :'+e.toString());
      print('Exception occurs');
    }

}



}