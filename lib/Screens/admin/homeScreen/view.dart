import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:d_net/Screens/admin/controller.dart';
import 'package:d_net/Screens/admin/homeScreen/controller.dart';
import 'package:d_net/Screens/admin/homeScreen/update.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminView extends GetView<AdminController> {
  AdminView({Key? key}) : super(key: key);
  final db = FirebaseFirestore.instance.collection("user");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
        actions: [
          IconButton(
              onPressed: () {
                controller.signOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: 100,
            color: Colors.blueGrey,
            child: Center(
              child: TypewriterAnimatedTextKit(
                text: ['Dream Net'],
                speed: Duration(milliseconds: 300),
                pause: Duration(milliseconds: 400),
                textStyle: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: controller.state.dbref,
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
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 1),
                          child: GestureDetector(
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
                              title: Text(snapshot.data!.docs[index]['UserName']
                                  .toString()),
                              subtitle: Text(snapshot
                                  .data!.docs[index]['address']
                                  .toString()),
                            ),
                          ),
                        );
                      }),
                );
              }),
        ],
      )),
    );
  }
}
