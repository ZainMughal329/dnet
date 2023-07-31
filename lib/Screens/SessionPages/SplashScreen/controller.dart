import 'dart:async';

import 'package:d_net/Utilities/ReusableComponents/utilis.dart';
import 'package:d_net/Utilities/Routes/routesNames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{

  void checkLogin(){
    final auth = FirebaseAuth.instance;
    try{
      if(auth.currentUser !=null){
        print(" user not null");
        Future.delayed(Duration(seconds: 3), () {
          Get.offNamed(RoutesNames.userScreen);
        });
      }else{
        print(" user  null");
        Future.delayed(Duration(seconds: 3), () {
          Get.offNamed(RoutesNames.loginScreen);
        });
      }
    }catch (e){
      print(" Exception ");
      Utils.showToast(e.toString());
      Get.offAll(Scaffold(body: Center(child: Text("Error Occurred"),),));
    }
    //
    // Future.delayed(Duration(seconds: 3),(){
    //
    // });


  }


}