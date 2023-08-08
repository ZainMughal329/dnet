import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_net/Screens/admin/homeScreen/state.dart';
import 'package:http/http.dart' as http;

// import 'package:d_net/Screens/admin/state.dart';
import 'package:d_net/Utilities/Routes/routesNames.dart';
import 'package:d_net/Utilities/models/userModel.dart';
import 'package:d_net/Utilities/services/shared_pref_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utilities/ReusableComponents/utilis.dart';

// import '../../Utilities/ReusableComponents/utilis.dart';
// import '../../Utilities/Routes/routesNames.dart';

class AdminController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 5, vsync: this);
    fetchData();
    // calculateRemainingDays();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
    print('object');
  }

  final state = AdminState();

  AdminController();

  final auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance.collection('users');

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<DocumentSnapshot> data = RxList<DocumentSnapshot>();
  RxList<DocumentSnapshot> filteredDataList = RxList<DocumentSnapshot>();

  void fetchData() async {
    try {
      var snapshot = await _firestore.collection('users').get();
      print('Snapshot is : ' + snapshot.toString());
      data.assignAll(snapshot.docs);
    } catch (e) {
      // Handle any errors that might occur during data retrieval.
      print('Error fetching data: $e');
    }
  }

  void search(String query) {
    print('Inside search');
    // Perform the search and update the data list.
    // if (query.isEmpty) {
    //   print('inside search if');
    //   Center(child: Text('data'));
    // } else {
    //   print('inside search else');
    //   var filteredData = data.where((snapshot) {
    //     // Customize this condition based on your Firestore document structure and search requirements.
    //     print('object11');
    //     String name = snapshot['Email'].toString().toLowerCase();
    //     print('Name is : ' + name.toString());
    //     print('Contains :' + name.contains(query.toLowerCase()).toString());
    //     return name.contains(query.toLowerCase());
    //   }).toList();
    //   filteredDataList.assignAll(filteredData);
    //   print('Filter list is : ' + filteredDataList.toString());
    // }
    // update();
    List<DocumentSnapshot> results = [];
    if(query.isEmpty) {
      results = data;
    }else {
      results = data.where((ele) => ele['UserName'].toString().toLowerCase().contains(query.toLowerCase())).toList();
    }
    filteredDataList.value = results;
  }

  // void startSearch() {
  //   state.isSearching.value = true;
  // }
  //
  // void stopSearch() {
  //   state.isSearching.value = false;
  // }

  setLogoutLoading(value) {
    state.logoutLoading.value = value;
  }

  void signOut() async {
    setLogoutLoading(true);
    try {
      sharedPrefrences().setAdminLogin(false).then((value) {
        setLogoutLoading(false);
        Utils.showToast("Admin Logout Successfully");
        Get.offNamed(RoutesNames.loginScreen);
      }).onError((error, stackTrace) {
        setLogoutLoading(false);
        Utils.showToast("Admin Logout Successfully");
        Utils.showToast(error.toString());
        Get.offNamed(RoutesNames.loginScreen);
      });
      // await auth.signOut().then((value) {
      //
      //   Utils.showToast("Signed Out Successfully");
      //   Get.offAllNamed(RoutesNames.loginScreen);
      // }).onError((error, stackTrace) {
      //   Utils.showToast("Error Occurred :" + error.toString());
      // });
    } catch (e) {
      setLogoutLoading(false);
      Utils.showToast("Error Occurred : " + e.toString());
    }
  }

  int calculateRemainingDays() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid.toString())
        .snapshots()
        .listen((doc) {
      state.startDateTime.value =
          DateTime.parse(doc['pkgStartDate'].toString());
      state.endDateTime.value = DateTime.parse(doc['pkgEndDate'].toString());
    });
    // Calculate the difference between endDateTime and startDateTime
    Duration difference =
        state.endDateTime.value.difference(state.startDateTime.value);

    // Get the number of remaining days from the difference
    int remainingDays = difference.inDays;

    // Return the remaining days
    return remainingDays;
  }

  dynamic getUserData() {
    print("inside getUserData code");

    return FirebaseFirestore.instance.collection('users').doc().snapshots();
  }

  Future<UserModel> getUserDataToUpdate(String id) async {
    print('inside update');
    final snapshot = await _db.where('id', isEqualTo: id).get();
    print('1st line');
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    print('2nd line');
    return userData;
  }

  getUsersData(String id) async {
    if (id != '') {
      print('inside id');
      return await getUserDataToUpdate(id);
    } else {
      Get.snackbar('Error', 'Something went wrong');
    }
  }

  updateStartDate(BuildContext context) async {
    DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1978),
      lastDate: DateTime(2099),
    );
    if (pickDate != null) {
      state.selectedStartDate = pickDate;
      update();
    } else {
      print('Null or something else');
    }
  }

  updateEndDate(BuildContext context) async {
    DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: state.selectedEndDate,
      firstDate: DateTime(1978),
      lastDate: DateTime(2099),
    );
    if (pickDate != null) {
      state.selectedEndDate = pickDate;
      update();
    } else {
      print('Null or something else');
    }
  }

  updateUserData(UserModel user) async {
    print('object 1w');
    print('id is : ' + user.id.toString());
    await _db.doc(user.id).update(
          user.toJson(),
        );
  }

  updateUser(UserModel user) async {
    print('id is :' + user.id.toString());
    await updateUserData(user);
  }

  setNotificationLoading(value) {
    state.notificationLoading.value = value;
  }

  Future<void> sendNotification(String users) async {
    setNotificationLoading(true);
    if (users == 'all') {
      await sendToAll();
      setNotificationLoading(false);
    }
    if(users == "expired"){
      await sendToExpired();
      setNotificationLoading(false);
    }
    if(users == "1"){
      await sendTo1dayLeft();
      setNotificationLoading(false);
    }
    if(users == "2"){
      await sendTo2dayLeft();
      setNotificationLoading(false);
    }
    if(users == "3"){
      await sendTo3dayLeft();
      setNotificationLoading(false);
    }
  }

  Future<void> sendToAll() async {
    final _querySnapshot = await state.db.get();
    for (var doc in _querySnapshot.docs) {
      var userToken = doc.data()['deviceToken'];
      // print(userToken);
      sendMessage(userToken);
    }
  }




  Future<void> sendToExpired() async {
    final _querySnapshot = await state.db.get();
    for(var doc in _querySnapshot.docs){
      String userToken = doc.data()['deviceToken'];
      DateTime start = DateTime.now();
      DateTime end = DateTime.parse(doc.data()['pkgEndDate']
          .toString())
          .add(Duration(days: 1));

      Duration difference = end.difference(start);

      int remaining = difference.inDays;
      // print('Index : ' + doc.i.toString());
      // print('Remaining are : ' + remaining.toString());
      if(remaining==0){
        sendMessage(userToken);
      }
    }
  }


  Future<void> sendTo1dayLeft() async {
    final _querySnapshot = await state.db.get();
    for(var doc in _querySnapshot.docs){
      String userToken = doc.data()['deviceToken'];
      DateTime start = DateTime.now();
      DateTime end = DateTime.parse(doc.data()['pkgEndDate']
          .toString())
          .add(Duration(days: 1));

      Duration difference = end.difference(start);

      int remaining = difference.inDays;
      // print('Index : ' + doc.i.toString());
      // print('Remaining are : ' + remaining.toString());
      if(remaining==1){
        sendMessage(userToken);
      }
    }
  }

  Future<void> sendTo2dayLeft() async {
    final _querySnapshot = await state.db.get();
    for(var doc in _querySnapshot.docs){
      String userToken = doc.data()['deviceToken'];
      DateTime start = DateTime.now();
      DateTime end = DateTime.parse(doc.data()['pkgEndDate']
          .toString())
          .add(Duration(days: 1));

      Duration difference = end.difference(start);

      int remaining = difference.inDays;
      // print('Index : ' + doc.i.toString());
      // print('Remaining are : ' + remaining.toString());
      if(remaining==2){
        sendMessage(userToken);
      }
    }
  }

  Future<void> sendTo3dayLeft() async {
    final _querySnapshot = await state.db.get();
    for(var doc in _querySnapshot.docs){
      String userToken = doc.data()['deviceToken'];
      DateTime start = DateTime.now();
      DateTime end = DateTime.parse(doc.data()['pkgEndDate']
          .toString())
          .add(Duration(days: 1));

      Duration difference = end.difference(start);

      int remaining = difference.inDays;
      // print('Index : ' + doc.i.toString());
      // print('Remaining are : ' + remaining.toString());
      if(remaining==3){
        sendMessage(userToken);
      }
    }
  }







  Future<void> sendMessage(String userToken) async  {
    var data = {
      'to': userToken,
      'priority': 'high',
      // 'channel': '1',
      'notification': {
        'title': 'Dubai Sky Net',
        'body': 'Pay your bill to enjoy limit less internet',
        // 'channel': '1',
      },
      //this is pay load
      'data': {
        'type': 'msg',
        'id': '1',
        // 'channel': '1',
      }
    };
    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(data),
        headers: {
          // 'channel': '1',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'key=AAAAYuY1WU0:APA91bE0J2mr-Wtc7P8HGl_22wPHqAplqEi8614RO2J7GvO7x18cqSt1Dfs7iswA_SfmTI9R-izU_dpVT-zu6XmHBJeLCv-lUZJVARQ6MAWjpeZvBy-boh3ZCiRaHrDledtg8JKx9KhN',
        });
  }
}
