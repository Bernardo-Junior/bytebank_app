// ignore_for_file: unused_import

import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/dio/web_client.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() async {
  runApp(BytebankApp());
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
