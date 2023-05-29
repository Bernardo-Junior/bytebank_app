// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class VerifyDashboardScreenExists
    extends Given1WithWorld<String, FlutterWorld> {
  VerifyDashboardScreenExists()
      : super(
          StepDefinitionConfiguration()
            ..timeout = const Duration(
              seconds: 10,
            ),
        );

  @override
  Future<void> executeStep(String key) async {
    final scaffoldReference = find.byValueKey(key);

    bool menusExists = await FlutterDriverUtils.isPresent(
      world.driver,
      scaffoldReference,
    );

    expect(menusExists, true);
  }

  @override
  RegExp get pattern =>
      RegExp(r"I have the dashboard screen with {string} scaffold");
}
