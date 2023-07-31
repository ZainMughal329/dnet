import 'package:d_net/Screens/admin/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminView extends GetView<AdminController> {
  const AdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
        actions: [
          IconButton(onPressed: (){
            controller.signOut();
          }, icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
