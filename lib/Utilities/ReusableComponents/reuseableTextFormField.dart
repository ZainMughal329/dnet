
import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  // Add your form fields' controllers here if needed
  final TextEditingController _myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stylish TextFormField'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Example TextFormField with custom styling
            TextFormField(
              controller: _myController,
              style: TextStyle(color: Colors.blue, fontSize: 18),
              decoration: InputDecoration(
                labelText: 'Your Name',
                labelStyle: TextStyle(color: Colors.blue),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.withOpacity(0.5), width: 1.0),
                ),
                filled: true,
                fillColor: Colors.blue.withOpacity(0.1),
              ),
            ),
            SizedBox(height: 20),
            // Add more TextFormField widgets with different styles as needed
            // For example, you can add email, password fields, etc.
          ],
        ),
      ),
    );
  }
}