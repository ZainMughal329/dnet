import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AdminState {

  final dbref = FirebaseFirestore.instance.collection("users").snapshots();
  final db = FirebaseFirestore.instance.collection("users");
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final searchController = TextEditingController().obs;
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now().add(Duration(days: 30),);


  final  package = "".obs;
  RxBool loading = false.obs;
  RxBool logoutLoading =false.obs;
  RxBool notificationLoading = false.obs;

  RxInt remainingDays = 0.obs;
  Rx<DateTime> startDateTime = Rx<DateTime>(DateTime.now());
  Rx<DateTime> endDateTime = Rx<DateTime>(DateTime.now());

  var isSearchBarOpen = false.obs;

  RxString name = "".obs;
}