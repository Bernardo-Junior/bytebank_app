import 'package:bytebank/dio/web_client.dart';
import 'package:bytebank/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(BytebankApp());
  findAll().then((transactions) => print('New transactions $transactions'));
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
