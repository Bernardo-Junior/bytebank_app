import 'package:bytebank/models/menu.dart';
import 'package:bytebank/screens/contact/contact_screen.dart';
import 'package:bytebank/screens/dashboard/widgets/menu.dart';
import 'package:bytebank/screens/transaction/transaction_screen.dart';
import 'package:bytebank/screens/transfer/transfer_screen.dart';

import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final menu = [
    Menu(
      name: 'Contacts',
      icon: Icons.people,
      page: ContactsScreen(),
    ),
    Menu(
      name: 'Transfers',
      icon: Icons.monetization_on,
      page: TransferScreen(),
    ),
    Menu(
      name: 'Transfers online',
      icon: Icons.monetization_on,
      page: TransferScreen(),
    ),
    Menu(
      name: 'Transaction Feed',
      icon: Icons.description,
      page: TransactionScreen(),
    ),
  ];

  DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DashBoard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'lib/assets/images/bytebank_logo.png',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: menu.length,
                itemBuilder: (context, index) {
                  final item = menu[index];
                  return MenuComponent(menu: item);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
