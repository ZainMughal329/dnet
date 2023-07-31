import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{

  static showToast(String msg){
    Fluttertoast.showToast(
        msg: msg,
      backgroundColor: Colors.white,
      textColor: Colors.black,
    );
  }



}