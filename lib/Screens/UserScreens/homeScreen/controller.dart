import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_net/Screens/UserScreens/homeScreen/state.dart';
import 'package:d_net/Utilities/ReusableComponents/utilis.dart';
import 'package:d_net/Utilities/Routes/routesNames.dart';
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
      state.endDateTime.value = DateTime.parse(doc['pkgEndDate'].toString());

      // Calculate remaining days and update the observable value
      state.remainingDays.value = calculateRemainingDays(
          state.startDateTime.value, state.endDateTime.value);
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getNodeData() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid.toString())
        .snapshots();
  }

  void signOut() async {
    try {
      await auth.signOut().then((value) {
        Utils.showToast("Signed Out Successfully");
        Get.offAllNamed(RoutesNames.loginScreen);
      }).onError((error, stackTrace) {
        Utils.showToast("Error Occurred :" + error.toString());
      });
    } catch (e) {
      Utils.showToast("Error Occurred : " + e.toString());
    }
  }

  int calculateRemainingDays(DateTime startDateTime, DateTime endDateTime) {
    // Calculate the difference between endDateTime and startDateTime
    Duration difference = endDateTime.difference(startDateTime);

    // Get the number of remaining days from the difference
    int remainingDays = difference.inDays;

    // Return the remaining days
    return remainingDays;
  }
}
