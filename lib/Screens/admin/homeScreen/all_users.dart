import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_net/Screens/admin/homeScreen/controller.dart';
import 'package:d_net/Screens/admin/homeScreen/update.dart';
import 'package:d_net/Utilities/ReusableComponents/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllUsers extends GetView<AdminController> {
  const AllUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("users").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('Waiting..');
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  print(snapshot.data!.docs.length);
                }
                print("snapshot.data");
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index]['UserName'];
                        print('data is:' + data.toString());

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 1),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print('object');
                                  print('id is: ' +
                                      snapshot.data!.docs[index].id.toString());
                                  Get.to(() => UpdateScreen(
                                        id: snapshot.data!.docs[index].id
                                            .toString(),
                                      ));
                                },
                                child: ListTile(
                                  tileColor: kPrimaryMediumColor,
                                  leading: CircleAvatar(
                                    backgroundColor: kPrimaryColor,
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.speed,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]['pkgType']
                                                .toString() +
                                            " MB/s",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
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
                              ),
                            ],
                          ),
                        );
                      }),
                );
              }),
          Obx(() {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                  onPressed: () {
                    controller.sendNotification('all');
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
