// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class VerifyContactExists extends And1WithWorld<String, FlutterWorld> {
  VerifyContactExists()
      : super(
          StepDefinitionConfiguration()
            ..timeout = const Duration(
              seconds: 10,
            ),
        );

  @override
  Future<void> executeStep(String key) async {
    final contactItemReference = find.byValueKey(key);

    bool contactItemExists = await FlutterDriverUtils.isPresent(
      world.driver,
      contactItemReference,
    );

    expect(contactItemExists, true);
  }

  @override
  RegExp get pattern => RegExp(r"I have the {string} contact exists");
}
