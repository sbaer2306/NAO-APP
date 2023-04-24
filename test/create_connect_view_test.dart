import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nao_app/providers/robot_provider.dart';
import 'package:provider/provider.dart';

import 'package:nao_app/pages/create_connect_view.dart';
import 'package:nao_app/ui_elements/connecting_alert_dialog.dart';

void main() {
  final widget = ChangeNotifierProvider(
      create: (context) => RobotProvider(),
      child: const MaterialApp(
        home: CreateConnectPage(),
        //navigatorObservers: [mockObserver],
      ));

  testWidgets('write a IP-Address', (tester) async {
    await tester.pumpWidget(widget);
    await tester.enterText(find.byType(TextField), '192.168.123.1');
    expect(find.text("192.168.123.1"), findsOneWidget);
  });

  testWidgets('Pressed Button show a AlertDialog', (tester) async {
    await tester.pumpWidget(widget);
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.byType(ConnectingDialog), findsOneWidget);
  });
}
