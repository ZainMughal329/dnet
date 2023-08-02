import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_net/Screens/UserScreens/homeScreen/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.chkNotifications();
    return Scaffold(
      appBar: AppBar(
        title: Text('UserView'),
        backgroundColor: Colors.blueGrey,
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
                    // height: 300,
                    child: Icon(Icons.person_2,size: 200,color: Colors.blueGrey.shade600,),
                  ),
                  Container(
                    // height: 500,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
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
                        Divider(color: Colors.grey, height: 5),
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
                              'Address',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Text(
                              snapshot.data!['address'].toString(),
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
                              'Start DateTime',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Text(
                              DateFormat.yMMMd().add_jm().format(
                                    DateTime.parse(
                                      snapshot.data!['pkgStartDate'].toString(),
                                    ),
                                  ),
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
                              'End DateTime',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Text(
                              DateFormat.yMMMd().add_jm().format(
                                    DateTime.parse(
                                      snapshot.data!['pkgEndDate'].toString(),
                                    ),
                                  ),
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
                        Divider(color: Colors.grey, height: 5),
                        Container(
                          height: 50,
                          child: ListTile(
                            onTap: () {},
                            title: Text(
                              'Remaining days',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Obx(
                              () => Text(
                                'Remaining Days: ${controller.state.remainingDays.value}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Divider(color: Colors.grey, height: 5),
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
