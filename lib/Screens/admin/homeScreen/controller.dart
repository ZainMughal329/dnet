import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_net/Screens/admin/homeScreen/state.dart';

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
    if(query.isEmpty) {
      print('inside search if');
       Center(child: Text('data'));
    }
      else {
      print('inside search else');
      var filteredData = data.where((snapshot) {
        // Customize this condition based on your Firestore document structure and search requirements.
        print('object11');
        String name = snapshot['UserName'].toString().toLowerCase();
        print('Name is : ' + name.toString());
        return name.contains(query.toLowerCase());
      }).toList();
      filteredDataList.assignAll(filteredData);
    }
      update();
  }

  // void startSearch() {
  //   state.isSearching.value = true;
  // }
  //
  // void stopSearch() {
  //   state.isSearching.value = false;
  // }


  setLogoutLoading(value){
    state.logoutLoading.value=value;
  }

  void signOut() async {
    setLogoutLoading(true);
    try {
      sharedPrefrences().setAdminLogin(false).then((value){
        setLogoutLoading(false);
        Utils.showToast("Admin Logout Successfully");
        Get.offNamed(RoutesNames.loginScreen);
      }).onError((error, stackTrace){
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
      state.startDateTime.value = DateTime.parse(doc['pkgStartDate'].toString());
      state.endDateTime.value = DateTime.parse(doc['pkgEndDate'].toString());

    });
    // Calculate the difference between endDateTime and startDateTime
    Duration difference = state.endDateTime.value.difference(state.startDateTime.value);

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
}
