import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_net/Screens/admin/homeScreen/state.dart';
// import 'package:d_net/Screens/admin/state.dart';
import 'package:d_net/Utilities/Routes/routesNames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../Utilities/ReusableComponents/utilis.dart';
// import '../../Utilities/ReusableComponents/utilis.dart';
// import '../../Utilities/Routes/routesNames.dart';

class AdminController extends GetxController {
  final state = AdminState();
  AdminController();
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
  dynamic getUserData() {
    print("inside getUserData code");

    return FirebaseFirestore.instance
        .collection('users').doc().snapshots();
  }

}