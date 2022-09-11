import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:rent_calculator/database_manager.dart';
import 'package:rent_calculator/main.dart';
import 'package:rent_calculator/model/single_room.dart';

class NewReceipt extends StatelessWidget {
  String? selectedValue;
  NewReceipt(this.selectedValue);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const MyCustomForm(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //  SingleRoom response = DatabaseManager().fetchSingleRoom();
    // Build a Form widget using the _formKey created above.
    SingleRoom room = DatabaseManager().fetchSingleRoom();
    print(room);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            initialValue: (room.current_units).toString(),
            decoration: const InputDecoration(
              icon: Icon(Icons.lightbulb_circle),
              labelText: 'Enter current units',
            ),
            onSaved: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter current units';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: (room.prev_units).toString(),
            decoration: const InputDecoration(
              icon: Icon(Icons.lightbulb_circle),
              labelText: 'Enter previous units',
            ),
            onSaved: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter previous units';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: (room.name).toString(),
            decoration: const InputDecoration(
              icon: Icon(Icons.lightbulb_circle),
              labelText: 'Enter maintenance',
            ),
            onSaved: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please maintenance';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: (room.price_per_units).toString(),
            decoration: const InputDecoration(
              icon: Icon(Icons.lightbulb_circle),
              labelText: 'Enter price per unit',
            ),
            onSaved: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter price per unit';
              }
              return null;
            },
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ButtonBar(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Go back'),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
