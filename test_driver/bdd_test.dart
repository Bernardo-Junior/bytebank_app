// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';

import 'steps/contacts/and/verify_contact_exists.dart';
import 'steps/contacts/given/verify_contact_form.dart';
import 'steps/contacts/then/tap_on_create_contact_button.dart';
import 'steps/contacts/given/verify_dashboard_screen_exists.dart';
import 'steps/contacts/when/tap_on_contacts_screen.dart';
import 'steps/transactions/then/verify_transaction_exists.dart';
import 'steps/transactions/when/tap_on_transaction_feed_screen.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [Glob(r"test_driver/features/**.feature")]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './report.json')
    ] // you can include the "StdoutReporter()" without the message level parameter for verbose log information
    // ..hooks = [HookExample()]

    ..stepDefinitions = [
      VerifyDashboardScreenExists(),
      // TapOnContactsScreen(),
      // TapOnCreateContactButton(),
      // VerifyContactForm(),
      // VerifyContactExists(),
      TapOnTransactionFeedScreen(),
      VerifyTransactionExists()
    ]
    ..stopAfterTestFailed = true
    // ..customStepParameterDefinitions = [ColourParameter()]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test_driver/bdd.dart";
  // ..tagExpression = "@smoke" // uncomment to see an example of running scenarios based on tag expressions
  return GherkinRunner().execute(config);
}
