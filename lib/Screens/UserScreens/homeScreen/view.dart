import 'package:d_net/Screens/UserScreens/homeScreen/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UserView'),
      ),
    );
  }
}
