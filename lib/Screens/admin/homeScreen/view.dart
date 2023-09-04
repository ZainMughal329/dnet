// import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_net/Screens/SessionPages/signUpPage/view.dart';
import 'package:d_net/Screens/admin/homeScreen/all_users.dart';
// import 'package:d_net/Screens/admin/controller.dart';
import 'package:d_net/Screens/admin/homeScreen/controller.dart';
import 'package:d_net/Screens/admin/homeScreen/expired_users.dart';
import 'package:d_net/Screens/admin/homeScreen/one_day.dart';
import 'package:d_net/Screens/admin/homeScreen/three_day.dart';
import 'package:d_net/Screens/admin/homeScreen/two_days.dart';
import 'package:d_net/Screens/admin/homeScreen/update.dart';
import 'package:d_net/Utilities/ReusableComponents/constants.dart';
import 'package:d_net/Utilities/Routes/routesNames.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              ? GetBuilder<AdminController>(builder: (con) {
                  return TextField(
                    onChanged: (value) {
                      con.search(value);
                    },
                    decoration: InputDecoration(
                      // ),
                      hintText: 'Search...',
                      border: InputBorder.none,
                    ),
                  );
                })
              : Center(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        "Dubai Sky Net",
                        speed: Duration(milliseconds: 550),
                        textStyle: TextStyle(
                          fontSize: 30.0,
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
              },
              icon: Icon(controller.state.isSearchBarOpen.value == true
                  ? Icons.close
                  : Icons.search),
            );
          }),
          // Obx(() => controller.state.isSearchBarOpen.value
          //     ? Container()
          //     : IconButton(
          //         onPressed: () {
          //           _showLogoutDialogue(context);
          //         },
          //         icon: Icon(
          //           Icons.power_settings_new,
          //           size: 30,
          //         ))),
          IconButton(
            onPressed: (){
              Get.toNamed(RoutesNames.signUpScreen);

            },
            icon: Icon(Icons.add),),
          SizedBox(
            width: 5,
          ),
        ],
      ),
      body: Obx(() => controller.state.isSearchBarOpen.value
          ? ListView.builder(
              itemCount: controller.filteredDataList.length,
              itemBuilder: (context, index) {
                print('Length is :' +
                    controller.filteredDataList.length.toString());
                // Customize this part based on your data structure.
                var item = controller.filteredDataList[index];
                print('Item is : ' + item.toString());
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          print('object');
                          print('id is: ' + item['id'].toString());
                          Get.to(() => UpdateScreen(
                                id: item['id'].toString(),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.speed,
                                color: Colors.white,
                                size: 30,
                              ),
                              Text(
                                item['pkgType'].toString() + " MB/s",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          title: Text(
                            (item['UserName'].toString())
                                .capitalizeFirst
                                .toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            (item['address'].toString()).toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : Padding(
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
            )),
    );
  }
}
