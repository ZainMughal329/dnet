import 'package:d_net/Screens/SessionPages/signUpPage/controller.dart';
import 'package:d_net/Utilities/Routes/routesNames.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../Utilities/ReusableComponents/already_have_an_account_acheck.dart';
import '../../../../Utilities/ReusableComponents/constants.dart';

class SignUpForm extends GetView<SignInController> {
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

  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: controller.state.nameController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (name) {},
            decoration: InputDecoration(
              hintText: "Your name",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding/2),
            child: TextFormField(
              controller: controller.state.emailController,
              textInputAction: TextInputAction.next,
              // obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Your email",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.email_outlined),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding/4),
            child: TextFormField(
              controller: controller.state.passController,
              textInputAction: TextInputAction.next,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding/4),
            child: TextFormField(
              controller: controller.state.phoneController,
              textInputAction: TextInputAction.next,
              // obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Your phone number",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.phone_android),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding/4),
            child: TextFormField(
              controller: controller.state.addressController,
              textInputAction: TextInputAction.next,
              // obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Your address",
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
                  child: GetBuilder<SignInController>(builder: (con) {
                    return TextFormField(
                      controller: controller.state.startDateController,
                      textInputAction: TextInputAction.next,
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                          // label: Text('Start date'),
                          // labelText: 'Start Date',
                          hintText: DateFormat.yMMMMd().format(
                            controller.state.selectedStartDate,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today_outlined , color: kPrimaryColor,),
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
                SizedBox(width: 7.0,),
                Expanded(
                  child: GetBuilder<SignInController>(
                    builder: (con) {
                      return TextFormField(
                        controller: controller.state.endDateController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            // label: Text('End Date'),
                            // labelText: 'Start Date',
                            hintText: DateFormat.yMMMMd().format(
                              controller.state.selectedEndDate,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.calendar_today_outlined , color: kPrimaryColor),
                              onPressed: () {
                                print('Hi there');
                                con.getEndDateFromUser(context);
                              },
                            )),
                        keyboardType: TextInputType.datetime,
                        readOnly: true,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding : EdgeInsets.symmetric(vertical: defaultPadding/4),
            child: Row(
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
          ),
          const SizedBox(height: defaultPadding / 2),
          Obx(
            () {
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
            },
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Get.toNamed(RoutesNames.loginScreen);
            },
          ),
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}
