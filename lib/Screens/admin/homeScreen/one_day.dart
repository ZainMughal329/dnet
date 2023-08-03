import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_net/Screens/admin/homeScreen/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OneDay extends GetView<AdminController> {
  const OneDay({Key? key}) : super(key: key);

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
                if (snapshot.hasData) {
                  print(snapshot.data!.docs.length);
                  print("snapshot.data");
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          print('object');
                          DateTime start = DateTime.now();
                          DateTime end = DateTime.parse(snapshot
                              .data!.docs[index]['pkgEndDate']
                              .toString()).add(Duration(days: 1));

                          Duration difference = end.difference(start);

                          int remaining = difference.inDays;
                          print('Index : ' + index.toString());
                          print('Remaining are : ' + remaining.toString());

                          if (remaining == 1) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 1),
                              child: ListTile(
                                tileColor: Colors.blueGrey.shade300,
                                leading: CircleAvatar(
                                    backgroundColor: Colors.blueGrey.shade200,
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    )),
                                trailing: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.speed),
                                    Text(snapshot.data!.docs[index]['pkgType']
                                            .toString() +
                                        " MB/s")
                                  ],
                                ),
                                title: Text(snapshot
                                    .data!.docs[index]['UserName']
                                    .toString()),
                                subtitle: Text(snapshot
                                    .data!.docs[index]['address']
                                    .toString()),
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
        ],
      )),
    );
  }
}
