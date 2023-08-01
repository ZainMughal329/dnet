import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class AdminState {

  final dbref = FirebaseFirestore.instance.collection("users").snapshots();

}