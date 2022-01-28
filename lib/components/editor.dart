import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Editor extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String hint;
  final IconData? icon;
  final List<TextInputFormatter>? formatter;
  final TextInputType typeInput;

  const Editor({
    Key? key,
    this.controller,
    required this.typeInput,
    required this.label,
    required this.hint,
    this.icon,
    this.formatter,
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
        inputFormatters: formatter != null ? formatter : null,
        keyboardType: typeInput,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
