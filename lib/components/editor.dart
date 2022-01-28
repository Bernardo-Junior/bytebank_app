import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData? icon;

  const Editor({
    Key? key,
    required this.controller,
    required this.label,
    required this.hint,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 13, left: 30, right: 30, bottom: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: icon != null ? Icon(icon) : null,
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
