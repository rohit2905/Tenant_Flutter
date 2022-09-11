import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rent_calculator/database_manager.dart';
import 'package:rent_calculator/new_receipt.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rent Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Rent Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  // Future<List<String>> dropDownOptions1 = DatabaseManager().getRoomsList();

  //     [
  //   "Select Room",
  //   "Ground Floor (1 BHK)",
  //   "Ground Floor (2 BHK)",
  //   "Single Room",
  //   "Single BedRoom 1",
  //   "Single BedRoom 2",
  //   "Pent House"
  // ];
  String? selectedItem = "Select Room";

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  onPressed() async {
    List dropDownOptions = await DatabaseManager().getRoomsList();
    String? selectedValue = "";
    AlertDialog alertDialog = AlertDialog(
      title: Text("Select a Room"),
      content: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(width: 3, color: Colors.blueAccent),
          ),
        ),
        value: selectedItem,
        items: dropDownOptions
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item, style: const TextStyle(fontSize: 16)),
                ))
            .toList(),
        onChanged: (item) => setState(() {
          selectedItem = item;
          selectedValue = selectedItem;
        }),
      ),
      actions: <Widget>[
        TextButton(
          child: Text("create"),
          onPressed: () {
            switch (selectedValue) {
              case "Single Room":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewReceipt(selectedValue)),
                );
                break;
            }
          },
        ),
        TextButton(
          child: Text("cancel"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: DropdownButtonFormField<String>(
      //   decoration: InputDecoration(
      //     enabledBorder: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(12),
      //       borderSide: const BorderSide(width: 3, color: Colors.blueAccent),
      //     ),
      //   ),
      //   value: selectedItem,
      //   items: dropDownOptions
      //       .map((item) => DropdownMenuItem<String>(
      //             value: item,
      //             child: Text(item, style: const TextStyle(fontSize: 24)),
      //           ))
      //       .toList(),
      //   onChanged: (item) => setState(() {
      //     selectedItem = item;
      //   }),
      // ),

      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Rent Calculator"),
      ),
      floatingActionButton: buildFloatingActionBar(),
    );
  }

  Widget buildFloatingActionBar() => FloatingActionButton.extended(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      icon: const Icon(Icons.add),
      foregroundColor: Colors.white,
      backgroundColor: Colors.green,
      label: const Text("Create new receipt"));
}
