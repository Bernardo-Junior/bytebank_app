// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class VerifyContactForm extends Given2WithWorld<String, String, FlutterWorld> {
  VerifyContactForm()
      : super(
          StepDefinitionConfiguration()
            ..timeout = const Duration(
              seconds: 10,
            ),
        );

  @override
  Future<void> executeStep(String key1, String key2) async {
    final input1Reference = find.byValueKey(key1);

    bool input1Exists = await FlutterDriverUtils.isPresent(
      world.driver,
      input1Reference,
    );

    final input2Reference = find.byValueKey(key2);

    bool input2Exists = await FlutterDriverUtils.isPresent(
      world.driver,
      input2Reference,
    );

    expect(input1Exists, true);
    expect(input2Exists, true);
  }

  @override
  RegExp get pattern => RegExp(r"I have {string} and {string}");
}
