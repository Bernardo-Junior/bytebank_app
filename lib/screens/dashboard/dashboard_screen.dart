import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DashBoard'),
      ),
      body: Column(
        children: [
          Image.asset(
            'lib/assets/images/bytebank_logo.png',
            width: 200,
            height: 200,
          ),
        ],
      ),
    );
  }
}
