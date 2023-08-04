import 'dart:async';
// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_net/Screens/UserScreens/homeScreen/state.dart';
import 'package:d_net/Utilities/ReusableComponents/utilis.dart';
import 'package:d_net/Utilities/Routes/routesNames.dart';
import 'package:d_net/Utilities/services/notification_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  UserController();

  final auth = FirebaseAuth.instance;
  late Timer _timer;
  final state = UserState();

  void onInit() {
    super.onInit();
    // Fetch startDateTime and endDateTime from Firestore using StreamBuilder





    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid.toString())
        .snapshots()
        .listen((doc) {
      state.startDateTime.value = DateTime.parse(doc['pkgStartDate'].toString());
      state.endDateTime.value = DateTime.parse(doc['pkgEndDate'].toString()).add(Duration(days: 1));

      // Calculate remaining days and update the observable value
      state.remainingDays.value = calculateRemainingDays(
          state.startDateTime.value, state.endDateTime.value);
    });
  }

  void chkNotifications() {
    print('Inside');
    NotificationServices notificationServices = NotificationServices();
    notificationServices.requestPermissions();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getNodeData() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid.toString())
        .snapshots();
  }

  void setLoading(bool value){
    state.loading.value=value;
  }

  void signOut() async {
    setLoading(true);
    try {
      await auth.signOut().then((value) {
        setLoading(false);
        Utils.showToast("Signed Out Successfully");
        Get.offAllNamed(RoutesNames.loginScreen);
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.showToast("Error Occurred :" + error.toString());
      });
    } catch (e) {
      setLoading(false);
      Utils.showToast("Error Occurred : " + e.toString());
    }
  }

  int calculateRemainingDays(DateTime startDateTime, DateTime endDateTime) {
    // Calculate the difference between endDateTime and startDateTime
    DateTime start = DateTime.now();
    Duration difference = endDateTime.difference(start);

    // Get the number of remaining days from the difference
    int remainingDays = difference.inDays;

    // Return the remaining days
    return remainingDays;
  }

  void updateToken()async{
   String? token =  await NotificationServices().getDeviceToken().then((value) {
     print("INside update Token");
     print(value.toString());
     FirebaseFirestore.instance
         .collection('users')
         .doc(auth.currentUser!.uid.toString()).update({
       'deviceToken' : value.toString(),
     }).then((value){
       print("Token Updated during HomeScreen");
     }).onError((error, stackTrace){
       print("Error on homeScreen Update");
       Utils.showToast("HomeScreen token Error : " + error.toString());
     });
   });



  }

}
