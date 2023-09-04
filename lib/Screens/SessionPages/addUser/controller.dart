import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_net/Screens/SessionPages/addUser/state.dart';
import 'package:d_net/Screens/SessionPages/addUser/view.dart';
import 'package:d_net/Screens/SessionPages/signUpPage/state.dart';
import 'package:d_net/Utilities/ReusableComponents/utilis.dart';
import 'package:d_net/Utilities/Routes/routesNames.dart';
import 'package:d_net/Utilities/models/userModel.dart';
import 'package:d_net/Utilities/services/notification_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddUserController extends GetxController {
  final state = AddUserState();

  AddUserController();

  final auth = FirebaseAuth.instance;
  final ref = FirebaseFirestore.instance;

  void setLoading(bool value) {
    state.loading.value = value;
  }

  void handleSignIn(String email, password) async {
    state.token = await NotificationServices().getDeviceToken();

    setLoading(true);
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        setLoading(false);
        print('id is  : ' + auth.currentUser!.uid.toString());
        ref.collection('users').doc(auth.currentUser!.uid.toString()).set(
              UserModel(
                id: auth.currentUser!.uid.toString(),
                email: state.emailController.text.toString(),
                phoneNo: state.phoneController.text.toString(),
                username: state.nameController.text.toString(),
                pkgStartDate: state.selectedStartDate.toString(),
                pkgEndDate: state.selectedEndDate.toString(),
                pkgType: state.package.toString(),
                password: state.passController.text.toString(),
                address: state.addressController.text.toString(),
                deviceToken: state.token.toString(),
              ).toJson(),
            );
        Utils.showToast('Account Created');
        Get.offAllNamed(RoutesNames.userScreen);
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.showToast('Error Occurred :' + error.toString());
        print('Error' + error.toString());
      });
    } catch (e) {
      setLoading(false);
      Utils.showToast('Error Occurred :' + e.toString());
      print('Exception occurs');
    }
  }

  getDateFromUser(BuildContext context) async {
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

  getEndDateFromUser(BuildContext context) async {
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
}
