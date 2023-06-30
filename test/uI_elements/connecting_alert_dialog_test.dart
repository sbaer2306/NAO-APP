import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:nao_app/ui_elements/connecting_alert_dialog.dart';
import 'package:animated_check/animated_check.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('Success Connection', () {
    testWidgets('AlertDialog shows a success Connection', (tester) async {
      await tester.pumpWidget(const MaterialApp(
          home: ConnectingDialog(code: 200, ip: "192.168.123.1")));

      expect(find.text("Verbindung erfolgreich"), findsOneWidget);
    });

    testWidgets('AlertDialog shows the right IP-Address', (tester) async {
      await tester.pumpWidget(const MaterialApp(
          home: ConnectingDialog(code: 200, ip: "192.168.123.1")));

      expect(
          find.text(
              "Sie sind mit dem NAO verbunden\nIP-Adresse: 192.168.123.1"),
          findsOneWidget);
    });

    testWidgets('AlertDialog shows a animation', (tester) async {
      await tester.pumpWidget(const MaterialApp(
          home: ConnectingDialog(code: 200, ip: "192.168.123.1")));

      expect(find.byType(AnimatedCheck), findsOneWidget);
    });
  });

  group('Failed Connection', () {
    testWidgets('AlertDialog shows a failed Connection', (tester) async {
      await tester.pumpWidget(const MaterialApp(
          home: ConnectingDialog(code: 500, ip: "192.168.123.1")));

      expect(find.text("Verbindung fehlgeschlagen"), findsOneWidget);
    });

    testWidgets('AlertDialog shows the statuscode', (tester) async {
      await tester.pumpWidget(const MaterialApp(
          home: ConnectingDialog(code: 500, ip: "192.168.123.1")));

      var statusCode = 500;
      expect(
          find.text(
              "Es konnte keine Verbindung hergestellt werden.\nStatuscode: $statusCode"),
          findsOneWidget);
    });
  });

  final mockObserver = MockNavigatorObserver();

  testWidgets('AlertDialog is closed after Button pressed', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: const ConnectingDialog(code: 200, ip: "192.168.123.1"),
      navigatorObservers: [mockObserver],
    ));

    await tester.tap(find.byType(OutlinedButton));
    await tester.pumpAndSettle();

    expect(find.byType(ConnectingDialog), findsNothing);
  });
}
