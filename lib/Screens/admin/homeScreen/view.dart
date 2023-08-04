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

  _showLogoutDialogue(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return controller.state.logoutLoading.value
              ? AlertDialog(
                  title: Text('Confirmation'),
                  content: Text('Are you sure you want to logout?'),
                  actions: [
                    Center(
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                  backgroundColor: kPrimaryLightColor,
                )
              : AlertDialog(
                  title: Text('Confirmation'),
                  content: Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () =>
                          Navigator.of(context).pop(), // cancel option
                      child: Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.signOut();

                        // insert logout method here
                        Navigator.of(context).pop();
                      },
                      child: Text('Yes'),
                    ),
                  ],
                );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => controller.state.isSearchBarOpen.value
              ? TextFormField(
                  // controller: controller.state.searchController,
                  onChanged: (value) {
                    controller.state.name.value = value;
                    print('value is :' +controller.state.name.toString());
                  },
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                  ),
                )
              : Center(
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
          Obx(() {
            return IconButton(
              onPressed: () {
                controller.state.isSearchBarOpen.toggle();
                // Toggle the search bar state
              },
              icon: Icon(controller.state.isSearchBarOpen.value == true
                  ? Icons.close
                  : Icons.search),
            );
          }),
          IconButton(
              onPressed: () {
                _showLogoutDialogue(context);
              },
              icon: Icon(
                Icons.power_settings_new,
                size: 30,
              )),
          SizedBox(
            width: 5,
          ),
        ],
      ),

      // appBar: AppBar(
      //   title: Obx(() => controller.state.isSearchBarOpen.value
      //       ? TextField(
      //     onChanged: (value) {
      //       // Handle search query here
      //       // You can use this value to filter your data accordingly
      //     },
      //     decoration: InputDecoration(hintText: 'Search...'),
      //   )
      //       : Text('All Users')), // Regular app title when not searching
      //   actions: [
      //     // Step 1: Add an icon to trigger the search bar
      //     IconButton(
      //       onPressed: () {
      //         controller.state.isSearchBarOpen.toggle(); // Toggle the search bar state
      //       },
      //       icon: Icon(controller.state.isSearchBarOpen.value ? Icons.close : Icons.search),
      //     ),
      //   ],
      // ),

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
