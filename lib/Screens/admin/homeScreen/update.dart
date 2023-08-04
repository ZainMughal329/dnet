import 'package:d_net/Screens/admin/homeScreen/view.dart';
import 'package:d_net/Utilities/ReusableComponents/constants.dart';
import 'package:d_net/Utilities/Routes/routesNames.dart';
import 'package:d_net/Utilities/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'controller.dart';

class UpdateScreen extends GetView<AdminController> {
  String id;

  UpdateScreen({Key? key, required this.id}) : super(key: key);

  Widget _buildPackageList(String pkg) {
    return Obx(
          () => Expanded(
        flex: 0,
        child: DropdownButton(
          iconEnabledColor: kPrimaryColor,
          dropdownColor: kPrimaryLightColor,

          borderRadius: BorderRadius.circular(10),
          // isDense: true,
          // isExpanded: true,
          // iconSize: 40,
          hint: controller.state.package.value == ""
              ? Text(pkg)
              : Text(controller.state.package.value),
          items: [
            DropdownMenuItem(
              child: Text("2-MB/s"),
              value: "2",
            ),
            DropdownMenuItem(
              child: Text("4-MB/s"),
              value: "4",
            ),
            DropdownMenuItem(
              child: Text("6-MB/s"),
              value: "6",
            ),
            DropdownMenuItem(
              child: Text("8-MB/s"),
              value: "8",
            ),
            DropdownMenuItem(
              child: Text("10-MB/s"),
              value: "10",
            ),
            DropdownMenuItem(
              child: Text("12-MB/s"),
              value: "12",
            ),
            DropdownMenuItem(
              child: Text("16-MB/s"),
              value: "16",
            ),
            DropdownMenuItem(
              child: Text("24-MB/s"),
              value: "24",
            ),
          ],
          onChanged: (String? value) {
            controller.state.package.value = value!;
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Data'),
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: controller.getUsersData(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print('inside if');

              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              print('inside snapshot');
              UserModel userModel = snapshot.data as UserModel;
              final email = TextEditingController(text: userModel.email);
              final phone = TextEditingController(text: userModel.phoneNo);
              final name = TextEditingController(text: userModel.username);
              final pass = TextEditingController(text: userModel.password);
              final add = TextEditingController(text: userModel.address);
              final pkgType = TextEditingController(text: userModel.pkgType);
              print('type : ' + userModel.pkgType.toString());
              final startDate =
                  TextEditingController(text: userModel.pkgStartDate);
              final endDate = TextEditingController(text: userModel.pkgEndDate);

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      SizedBox(height: 50.0),
                      TextFormField(
                        controller: name,

                        readOnly: true,
                        textInputAction: TextInputAction.next,
                        // obscureText: true,
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Icon(Icons.person),
                          ),
                        ),
                        // decoration: InputDecoration(labelText: 'Full Name'),
                      ),
                      Padding(
                        padding : EdgeInsets.symmetric(vertical: defaultPadding/2),
                        child: TextFormField(
                          controller: email,
                          readOnly: true,
                          textInputAction: TextInputAction.next,
                          // obscureText: true,
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Icon(Icons.email_outlined),
                            ),
                          ),
                          // decoration: InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      Padding(
                        padding : EdgeInsets.symmetric(vertical: defaultPadding/4),
                        child: TextFormField(
                          controller: pass,
                          // decoration: InputDecoration(labelText: 'Password'),
                          readOnly: true,
                          obscureText: true,
                          textInputAction: TextInputAction.next,
                          // obscureText: true,
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Icon(Icons.lock),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding : EdgeInsets.symmetric(vertical: defaultPadding/4),
                        child: TextFormField(
                          controller: phone,
                          readOnly: true,
                          // decoration: InputDecoration(labelText: 'Phone Number'),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          // obscureText: true,
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Icon(Icons.phone_android),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding : EdgeInsets.symmetric(vertical: defaultPadding/4),
                        child: TextFormField(
                          controller: add,

                          readOnly: true,
                          // decoration: InputDecoration(labelText: 'Address'),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          // obscureText: true,
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Icon(Icons.home_filled),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding : EdgeInsets.symmetric(vertical: defaultPadding/4),
                        child: Row(
                          children: [
                            Expanded(
                              child: GetBuilder<AdminController>(builder: (con) {
                                return TextFormField(
                                  controller:
                                      controller.state.startDateController,
                                  textInputAction: TextInputAction.next,
                                  // obscureText: true,
                                  cursorColor: kPrimaryColor,
                                  decoration: InputDecoration(
                                      // label: Text('Start date'),

                                      // labelText: 'Start Date',
                                      hintText: DateFormat.yMMMMd().format(
                                        DateTime.parse(controller.state.selectedStartDate.toString()),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.calendar_today_outlined , color: kPrimaryColor),
                                        onPressed: () {
                                          print('Hi there');
                                          con.updateStartDate(context);
                                        },
                                      )),
                                  keyboardType: TextInputType.datetime,
                                  readOnly: true,
                                );
                              }),
                            ),
                            SizedBox(width: 7.0,),
                            Expanded(
                              child: GetBuilder<AdminController>(builder: (con) {
                                return TextFormField(
                                  controller: controller.state.endDateController,
                                  textInputAction: TextInputAction.next,
                                  // obscureText: true,
                                  cursorColor: kPrimaryColor,
                                  decoration: InputDecoration(
                                      // label: Text('End Date' , style: TextStyle(color: kPrimaryColor),),

                                      // labelText: 'Start Date',
                                      hintText:DateFormat.yMMMMd().format(
                                        controller.state.selectedEndDate,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.calendar_today_outlined , color: kPrimaryColor,),
                                        onPressed: () {
                                          print('Hi there');
                                          con.updateEndDate(context);
                                        },
                                      )),
                                  keyboardType: TextInputType.datetime,
                                  readOnly: true,
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding : EdgeInsets.symmetric(vertical: defaultPadding/4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              // height: 20,
                              // width: 60,

                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: 10,),
                                    Text(
                                      "Package",
                                      style: TextStyle(
                                        // decoration: TextDecoration.underline,
                                          fontSize: 16,
                                          color: Colors.grey.shade700),
                                    ),

                                    SizedBox(width: 50,),
                                    Icon(Icons.shopping_bag_outlined,color: kPrimaryColor,),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: kPrimaryLightColor,
                                borderRadius: BorderRadius.circular(20),
                                // backgroundBlendMode: BlendMode.lighten
                                // border: Border.all(
                                //   // color: kPrimaryColor
                                // )
                              ),
                            ),
                            _buildPackageList(pkgType.text.toString()),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            var userData = UserModel(
                                id: id,
                                email: email.text.trim(),
                                phoneNo: phone.text.trim(),
                                username: name.text.trim(),
                                pkgStartDate: controller.state.selectedStartDate
                                    .toString(),
                                pkgEndDate:
                                    controller.state.selectedEndDate.toString(),
                                pkgType: controller.state.package.value == ""
                                    ? pkgType.text
                                    : controller.state.package.value,
                                password: pass.text.trim(),
                                address: add.text.trim());
                            await controller.updateUser(userData);
                            // Get.to(() => AdminView());
                            // Get.toNamed(RoutesNames.adminScreen);
                            Get.snackbar('Successfully updated', '');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            side: BorderSide.none,
                            shape: const StadiumBorder(),
                          ),
                          child: const Center(
                            child: Text(
                              'Save Profile',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
