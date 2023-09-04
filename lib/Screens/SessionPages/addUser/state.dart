import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddUserState {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now().add(
    Duration(days: 30),
  );

  final package = "".obs;
  RxBool loading = false.obs;

  String? token;
}
