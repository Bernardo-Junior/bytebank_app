import 'package:bytebank/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

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
