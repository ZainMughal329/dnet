import 'package:d_net/Utilities/ReusableComponents/utilis.dart';
import 'package:d_net/Utilities/Routes/routesNames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  UserController();
  final auth = FirebaseAuth.instance;
  void signOut() async{
    try{
      await auth.signOut().then((value){
        Utils.showToast("Signed Out Successfully");
        Get.offAllNamed(RoutesNames.loginScreen);

      }).onError((error, stackTrace){
        Utils.showToast("Error Occurred :"+ error.toString() );

      });
    }catch(e){
      Utils.showToast("Error Occurred : "+ e.toString());

    }
}
}