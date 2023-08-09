import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_net/Screens/UserScreens/homeScreen/state.dart';
import 'package:d_net/Utilities/ReusableComponents/utilis.dart';
import 'package:d_net/Utilities/Routes/routesNames.dart';
import 'package:d_net/Utilities/services/notification_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserController extends GetxController {
  UserController();

  final auth = FirebaseAuth.instance;
  late Timer _timer;
  final state = UserState();

  void onInit() {
    super.onInit();

    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid.toString())
        .snapshots()
        .listen((doc) {
      state.startDateTime.value =
          DateTime.parse(doc['pkgStartDate'].toString());
      state.endDateTime.value =
          DateTime.parse(doc['pkgEndDate'].toString()).add(Duration(days: 1));

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

  void setLoading(bool value) {
    state.loading.value = value;
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
    DateTime start = DateTime.now();
    Duration difference = endDateTime.difference(start);

    int remainingDays = difference.inDays;

    return remainingDays;
  }

  void updateToken() async {
    String? token = await NotificationServices().getDeviceToken().then((value) {
      print("INside update Token");
      print(value.toString());
      FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid.toString())
          .update({
        'deviceToken': value.toString(),
      }).then((value) {
        print("Token Updated during HomeScreen");
      }).onError((error, stackTrace) {
        print("Error on homeScreen Update");
        Utils.showToast("HomeScreen token Error : " + error.toString());
      });
    });
  }

  void initializeNotification(context) {
    NotificationServices().FirebaseInit(context);
  }

  void initializeLocalNotification() async {
    try{
      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid.toString())
          .get()
          .then((documentSnapshot) {
        if (documentSnapshot.exists) {
          String timestamp = documentSnapshot.data()![
          'pkgEndDate']; // replace 'your_date_field' with your actual date field name
          final format = DateFormat("yyyy-MM-dd HH:mm:ss.S");

          // Convert String to DateTime
          DateTime dateTime = format.parse(timestamp);
          DateTime newDateTime = dateTime.subtract(Duration(days: 1));
          print('Date and Time: $dateTime');

          print('Date and Time: $newDateTime');
          NotificationServices().showSheduleNotification(
            title: "Dubai Sky Net",
            body: "Pay Your Bill to enjoy LimitLess \nInternet Connectivity",
            sheduledTime: newDateTime,
          );
        } else {
          print('Document does not exist on the database');
        }
      });
    }catch(e){

    }
  }
}
