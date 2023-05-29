// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class TapOnSendButton extends Then1WithWorld<String, FlutterWorld> {
  TapOnSendButton()
      : super(
          StepDefinitionConfiguration()
            ..timeout = const Duration(
              seconds: 10,
            ),
        );

  @override
  Future<void> executeStep(String key) async {
    final buttonReference = find.byValueKey(key);

    bool buttonExists = await FlutterDriverUtils.isPresent(
      world.driver,
      buttonReference,
    );

    expect(buttonExists, true);

    await world.driver?.tap(buttonReference);
  }

  @override
  RegExp get pattern => RegExp(r"I tap the {string} button");
}
