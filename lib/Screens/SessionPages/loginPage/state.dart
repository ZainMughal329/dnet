import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class loginState {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  RxBool loading = false.obs;
  String? token;



}