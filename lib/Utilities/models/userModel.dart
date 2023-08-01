import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String email;
  final String phoneNo;
  final String username;
  final String pkgStartDate;
  final String pkgEndDate;
  final String pkgType;
  final String password;
  final String address;

  UserModel(
      {this.id,
        required this.email,
        required this.phoneNo,
        required this.username,
        required this.pkgStartDate,
        required this.pkgEndDate,
        required this.pkgType,
        required this.password,
      required this.address,
      });

  toJson() {
    return {
      'id' : id,
      'Email': email,
      'Phone': phoneNo,
      'UserName' : username,
      'pkgStartDate' : pkgStartDate,
      'pkgEndDate' : pkgEndDate,
      'pkgType' : pkgType,
      'Password': password,
      'address' : address,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return UserModel(
        id: documentSnapshot.id,
        email: data['Email'],
        phoneNo: data['Phone'],
        username: data['UserName'],
        pkgStartDate: data['pkgStartDate'],
        pkgEndDate: data['pkgEndDate'],
        pkgType: data['pkgType'],
        address: data['address'],
        password: data['Password']);

  }
}
