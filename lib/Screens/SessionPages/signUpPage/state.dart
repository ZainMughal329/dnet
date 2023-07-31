import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignState {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passController = TextEditingController();
  final addressController = TextEditingController();
  final  package = "".obs;
  RxBool loading = false.obs;



}