import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../loginPage/view.dart';
import 'controller.dart';

class SignUpScreen extends GetView<SignInController> {
  Widget _buildPackageList() {
    return Obx(
      () => Expanded(
        flex: 0,
        child: DropdownButton(
          iconEnabledColor: Colors.green,
          // iconSize: ,
          hint: controller.state.package.value == ""
              ? Text("Select Package")
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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50.0),
              TextFormField(
                controller: controller.state.nameController,
                decoration: InputDecoration(labelText: 'Full Name'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: controller.state.emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: controller.state.passController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: controller.state.phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: controller.state.addressController,
                decoration: InputDecoration(labelText: 'Address'),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: GetBuilder<SignInController>(builder: (con) {
                      return TextFormField(
                        controller: controller.state.startDateController,
                        decoration: InputDecoration(
                            label: Text('Start date'),
                            // labelText: 'Start Date',
                            hintText: DateFormat.yMMMMd().format(
                              controller.state.selectedStartDate,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.calendar_today_outlined),
                              onPressed: () {
                                print('Hi there');
                                con.getDateFromUser(context);
                              },
                            )),
                        keyboardType: TextInputType.datetime,
                        readOnly: true,
                      );
                    }),
                  ),
                  SizedBox(width: 16.0,),
                  Expanded(
                    child: GetBuilder<SignInController>(builder: (con) {
                      return TextFormField(
                        controller: controller.state.endDateController,
                        decoration: InputDecoration(
                            label: Text('End Date'),
                            // labelText: 'Start Date',
                            hintText: DateFormat.yMMMMd().format(
                              controller.state.selectedEndDate,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.calendar_today_outlined),
                              onPressed: () {
                                print('Hi there');
                                con.getEndDateFromUser(context);
                              },
                            )),
                        keyboardType: TextInputType.datetime,
                        readOnly: true,
                      );
                    }),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Package",
                    style: TextStyle(
                        // decoration: TextDecoration.underline,
                        fontSize: 16,
                        color: Colors.grey.shade700),
                  ),
                  _buildPackageList(),
                ],
              ),
              SizedBox(height: 24.0),
              Obx(() {
                return ElevatedButton(
                  onPressed: () {
                    controller.handleSignIn(
                        controller.state.emailController.text.trim().toString(),
                        controller.state.passController.text.trim().toString());
                  },
                  child: controller.state.loading.value == true
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        ))
                      : Center(child: Text('Sign Up')),
                );
              }),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Get.to(
                    () => LoginScreen(),
                  );
                },
                child: Text('Already have an account? Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
