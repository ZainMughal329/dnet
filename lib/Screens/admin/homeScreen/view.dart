import 'dart:async';

// import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_net/Screens/admin/homeScreen/all_users.dart';

// import 'package:d_net/Screens/admin/controller.dart';
import 'package:d_net/Screens/admin/homeScreen/controller.dart';
import 'package:d_net/Screens/admin/homeScreen/expired_users.dart';
import 'package:d_net/Screens/admin/homeScreen/one_day.dart';
import 'package:d_net/Screens/admin/homeScreen/three_day.dart';
import 'package:d_net/Screens/admin/homeScreen/two_days.dart';
import 'package:d_net/Screens/admin/homeScreen/update.dart';
import 'package:d_net/Utilities/ReusableComponents/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utilities/ReusableComponents/tab_bar_settings.dart';

class AdminView extends GetView<AdminController> {
  AdminView({Key? key}) : super(key: key);
  final db = FirebaseFirestore.instance.collection("user");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                "Dream Net",
                speed: Duration(milliseconds: 550),
                textStyle: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                cursor: '_',
                curve: Curves.linear,
              ),
            ],
          ),
        ),
        backgroundColor: kPrimaryColor,
        bottom: TabBar(
          controller: controller.tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: 'All\nusers'),
            Tab(text: 'Expired\nusers'),
            Tab(text: '1 day\nleft'),
            Tab(text: '2 days\nleft'),
            Tab(text: '3 days\nleft'),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                controller.signOut();
              },
              icon: Icon(Icons.logout)),
          SizedBox(
            width: 5,
          ),
          // PopupMenuButton(
          //     icon: Icon(Icons.more_vert_rounded),
          //     itemBuilder: (context) => [
          //           PopupMenuItem(
          //             value: 1,
          //             child: Text("Expired"),
          //           ),
          //           PopupMenuItem(
          //             value: 2,
          //             child: Text("Page 2"),
          //           ),
          //           PopupMenuItem(
          //             value: 3,
          //             child: Text("Page 3"),
          //           ),
          //         ],
          //   onSelected: (value) {
          //     switch (value) {
          //       case 1:
          //         Get.to(ExpiredUsers());
          //         break;
          //       case 2:
          //         Navigator.pushNamed(context, '/page2');
          //         break;
          //       case 3:
          //         Navigator.pushNamed(context, '/page3');
          //         break;
          //     }
          //   },
          // ),
        ],

      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       Container(
      //         child: Align(
      //           alignment: Alignment.topLeft,
      //           child: TabBar(
      //             isScrollable: true,
      //             labelPadding: EdgeInsets.only(right: 20, left: 20),
      //             indicator: CircleTabIndicator(color: Colors.black, radius: 4),
      //             controller: controller.tabController,
      //             labelColor: Colors.black,
      //             unselectedLabelColor: Colors.grey,
      //             tabs: [
      //               Tab(text: 'All users'),
      //               Tab(text: 'Expired users'),
      //               Tab(text: '1 day left'),
      //               Tab(text: '2 days left'),
      //               Tab(text: '3 days left'),
      //             ],
      //           ),
      //         ),
      //       ),
      //       Container(
      //         height: 590,
      //         width: double.infinity,
      //         child: TabBarView(
      //           controller: controller.tabController,
      //           children: [
      //             // Get.offAndToNamed(page)
      //             AllUsers(),
      //             ExpiredUsers(),
      //             OneDay(),
      //             TwoDays(),
      //             ThreeDays(),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),

      // backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TabBarView(
          controller: controller.tabController,
          children: [
            // Replace these with the content for each tab.
            AllUsers(),
            ExpiredUsers(),
            OneDay(),
            TwoDays(),
            ThreeDays(),
          ],
        ),
      ),
    );
  }
}
