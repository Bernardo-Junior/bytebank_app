import 'package:bytebank/screens/dashboard/dashboard_screen.dart';
import 'package:bytebank/screens/dashboard/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Should display the main image when the Dashboard is opened',
    (WidgetTester tester) async {
      // main Function (RunApp)
      await tester.pumpWidget(MaterialApp(home: DashboardScreen()));

      final mainImage = find.byType(Image);

      expect(mainImage, findsOneWidget);
    },
  );

  testWidgets(
      'Should display the transfer feature when the Dashboard is opened',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DashboardScreen(),
      ),
    );

    final tranferMenu = find.byWidgetPredicate((widget) =>
        menuComponentItem(widget, 'Transfers', Icons.monetization_on));

    expect(tranferMenu, findsOneWidget);
  });

  testWidgets(
      'Should display the transaction feed when the Dashboard is opened',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DashboardScreen(),
      ),
    );

    final transactionFeedMenu = find.byWidgetPredicate((widget) =>
        menuComponentItem(widget, 'Transaction Feed', Icons.description));

    expect(transactionFeedMenu, findsOneWidget);
  });
}

bool menuComponentItem(Widget widget, String name, IconData icon) {
  if (widget is MenuComponent) {
    return widget.menu.name == name && widget.menu.icon == icon;
  }
  return false;
}
