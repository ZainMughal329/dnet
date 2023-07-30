import 'package:flutter/material.dart';

class textField extends StatelessWidget {
  String hintText;
  String labelText;
  Icon prefixIcon;
  TextEditingController controller;
  FocusNode focusNode;
   textField({Key? key,required this.controller,required this.focusNode,required this.hintText,required this.prefixIcon,required this.labelText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,

      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        labelText: labelText,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),


    );
  }
}
