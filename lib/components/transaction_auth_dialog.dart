import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class TransactionAuthDialog extends StatefulWidget {
  final Function(String code) onConfirm;
  TransactionAuthDialog({
    Key? key,
    required this.onConfirm,
  }) : super(key: key);

  @override
  _TransactionAuthDialogState createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  TextEditingController inputCodeController = TextEditingController();
  bool isComplete = false;

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return AlertDialog(
      title: Text('Authenticate'),
      content: Container(
        width: width * 0.7,
        height: height * 0.08,
        margin: EdgeInsets.only(
          top: height * 0.015,
        ),
        child: PinCodeTextField(
          length: 4,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.underline,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 55,
            activeColor: Colors.blue,
            fieldWidth: 40,
            selectedFillColor: const Color(0XF7F7F7),
            activeFillColor: const Color(0XF7F7F7),
            disabledColor: Colors.white,
            inactiveColor: const Color(0XFFBDBDBD),
            selectedColor: Colors.blue,
            inactiveFillColor: const Color(0XF7F7F7),
            borderWidth: 1.3,
          ),
          keyboardType: TextInputType.numberWithOptions(
            decimal: false,
            signed: false,
          ),
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          errorAnimationController: errorController,
          controller: inputCodeController,
          backgroundColor: const Color(0XF7F7F7),
          onCompleted: (v) {
            setState(() {
              isComplete = true;
            });
          },
          onChanged: (value) {},
          beforeTextPaste: (text) {
            return false;
          },
          appContext: context,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: isComplete
              ? () {
                  widget.onConfirm(inputCodeController.text);
                  Navigator.of(context).pop();
                }
              : null,
          child: Text('Confirm'),
        ),
      ],
    );
  }
}
