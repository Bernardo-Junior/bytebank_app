// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class VerifyTransactionExists extends And1WithWorld<String, FlutterWorld> {
  VerifyTransactionExists()
      : super(
          StepDefinitionConfiguration()
            ..timeout = const Duration(
              seconds: 10,
            ),
        );

  @override
  Future<void> executeStep(String key) async {
    await world.driver!.waitFor(find.byValueKey(key));
  }

  @override
  RegExp get pattern => RegExp(r"I have the {string} transaction exists");
}
