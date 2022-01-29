import 'package:flutter/material.dart';

import 'package:bytebank/models/menu.dart';

class MenuComponent extends StatelessWidget {
  final Menu menu;

  const MenuComponent({
    Key? key,
    required this.menu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 2,
        color: Theme.of(context).colorScheme.primary,
        child: InkWell(
          overlayColor: MaterialStateProperty.all(
            Colors.green,
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return menu.page;
                },
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(8),
            height: 100,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  menu.icon,
                  color: Colors.white,
                  size: 24,
                ),
                Text(
                  menu.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
