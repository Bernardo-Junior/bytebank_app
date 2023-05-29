// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class TapOnTransactionFeedScreen extends When1WithWorld<String, FlutterWorld> {
  TapOnTransactionFeedScreen()
      : super(
          StepDefinitionConfiguration()
            ..timeout = const Duration(
              seconds: 10,
            ),
        );

  @override
  Future<void> executeStep(String key) async {
    final contactItemReference = find.byValueKey('item3');
    await world.driver?.scrollUntilVisible(
      find.byType('ListView'),
      contactItemReference,
      dxScroll: -100,
    );

    bool buttonExists = await FlutterDriverUtils.isPresent(
      world.driver,
      contactItemReference,
    );

    expect(buttonExists, true);

    await world.driver?.tap(contactItemReference);
  }

  @override
  RegExp get pattern => RegExp(r"I tap on the {string} button");
}
