import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

import 'models/contact.dart';

void main() {
  runApp(BytebankApp());
  // save(
  //   Contact(
  //     id: 0,
  //     name: 'Bernardo',
  //     accountNumber: 1000,
  //   ),
  // ).then((id) {
  //   findAll().then((contacts) => debugPrint(contacts.toString()));
  // });
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          // Colors from buttons
          secondary: Colors.blueAccent.shade700,
          // Color from text
          onPrimary: Colors.white,
          // Colors from icons
          onSecondary: Colors.white,
          // Colors from containers
          primary: Colors.green.shade900,
          onSurface: Colors.red,
        ),
      ),
      home: DashboardScreen(),
    );
  }
}
