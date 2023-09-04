import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_net/Screens/admin/homeScreen/controller.dart';
import 'package:d_net/Utilities/services/message_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../../Utilities/ReusableComponents/constants.dart';

class OneDay extends GetView<AdminController> {
  const OneDay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.state.recipients1.clear();
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("users").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data!.docs.length);
                  print("snapshot.data");
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          // print('object');

                          DateTime start = DateTime.now();
                          DateTime end = DateTime.parse(snapshot
                                  .data!.docs[index]['pkgEndDate']
                                  .toString())
                              .add(Duration(days: 1));

                          Duration difference = end.difference(start);

                          int remaining = difference.inDays;
                          print('Index : ' + index.toString());
                          print('Remaining are : ' + remaining.toString());

                          if (remaining == 1) {
                            controller.state.recipients1.add(snapshot.data!.docs[index]['Phone']);
                            print(index.toString());
                            print(controller.state.recipients1);
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 1),
                              child: ListTile(
                                tileColor: kPrimaryMediumColor,
                                leading: CircleAvatar(
                                    backgroundColor: kPrimaryColor,
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    )),
                                trailing: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.speed,
                                      color: kPrimaryColor,
                                      size: 30,
                                    ),
                                    Text(
                                      snapshot.data!.docs[index]['pkgType']
                                              .toString() +
                                          " MB/s",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                title: Text(
                                  (snapshot.data!.docs[index]['UserName']
                                          .toString())
                                      .capitalizeFirst
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: Text(
                                  (snapshot.data!.docs[index]['address']
                                          .toString())
                                      .toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('Waiting..');
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Text('');
              }),
          Obx(() {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                  onPressed: () {
                    controller.state.notificationLoading.value=true;
                    MessagesService().sendMessage(controller.state.recipients1);
                    controller.state.notificationLoading.value=false;
                    // print("Messages sent to :" );
                    // print(controller.state.recipients1);

                    // controller.sendNotification('1');
                  },
                  child: Container(
                    child: Center(
                      child: controller.state.notificationLoading == true
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text("Send Notification"),
                    ),
                  )),
            );
          })
        ],
      )),
    );
  }
}
