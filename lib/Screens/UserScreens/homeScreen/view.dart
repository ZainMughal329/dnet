import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_net/Screens/UserScreens/homeScreen/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UserView'),
        actions: [
          IconButton(
              onPressed: () {
                controller.signOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.getNodeData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print('Waiting..');
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            // DateTime startDate = snapshot.data!['pkgStartDate'];

            return Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    height: 330,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          child: ListTile(
                            onTap: () {},
                            title: Text(
                              'Email',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Text(
                              snapshot.data!['Email'].toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Divider(color: Colors.white, height: 5),
                        Container(
                          height: 50,
                          child: ListTile(
                            onTap: () {},
                            title: Text(
                              'Full Name',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Text(
                              snapshot.data!['UserName'].toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Divider(color: Colors.grey, height: 5),
                        Container(
                          height: 50,
                          child: ListTile(
                            onTap: () {},
                            title: Text(
                              'Phone',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Text(
                              snapshot.data!['Phone'].toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Divider(color: Colors.grey, height: 5),
                        Container(
                          height: 50,
                          child: ListTile(
                            onTap: () {},
                            title: Text(
                              'Start Date',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Text(
                              snapshot.data!['pkgStartDate'].toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Divider(color: Colors.grey, height: 5),
                        Container(
                          height: 50,
                          child: ListTile(
                            onTap: () {},
                            title: Text(
                              'End Date',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Text(
                              snapshot.data!['pkgEndDate'].toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Divider(color: Colors.grey, height: 5),
                        Container(
                          height: 50,
                          child: ListTile(
                            onTap: () {},
                            title: Text(
                              'Package Type',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Text(
                              snapshot.data!['pkgType'].toString() + ' Mbps',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        // Divider(color: Colors.grey,),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
