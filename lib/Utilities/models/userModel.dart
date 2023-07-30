import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String email;
  final String phoneNo;
  final String username;
  final String photoUrl;
  final String pkgType;
  final String password;

  UserModel(
      {this.id,
        required this.email,
        required this.phoneNo,
        required this.username,
        required this.photoUrl,
        required this.pkgType,
        required this.password});

  toJson() {
    return {
      'Email': email,
      'Phone': phoneNo,
      'UserName' : username,
      'profile' : photoUrl,
      'pkgType' : pkgType,
      'Password': password,
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
        photoUrl: data['profile'],
        pkgType: data['pkgType'],
        password: data['Password']);
  }
}
