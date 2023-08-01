import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_net/Screens/admin/homeScreen/state.dart';

// import 'package:d_net/Screens/admin/state.dart';
import 'package:d_net/Utilities/Routes/routesNames.dart';
import 'package:d_net/Utilities/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utilities/ReusableComponents/utilis.dart';

// import '../../Utilities/ReusableComponents/utilis.dart';
// import '../../Utilities/Routes/routesNames.dart';

class AdminController extends GetxController {
  final state = AdminState();

  AdminController();

  final auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance.collection('users');

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
