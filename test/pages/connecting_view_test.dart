import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nao_app/providers/robot_provider.dart';
import 'package:nao_app/models/robot_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nao_app/pages/connecting_view.dart';
import 'package:nao_app/pages/create_connect_view.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  final mockObserver = MockNavigatorObserver();

  final widget = ChangeNotifierProvider(
      create: (context) => RobotProvider(),
      child: MaterialApp(
        home: const ConnectView(

        ),
        navigatorObservers: [mockObserver],
      ));

  testWidgets('The Connecting View has a title', (tester) async {
    await tester.pumpWidget(widget);
    final titleFinder = find.text("Verbinden");

    expect(titleFinder, findsOneWidget);
  });

  testWidgets('The List of Connections is empty', (tester) async {
    await tester.pumpWidget(widget);
    expect(
        find.text("Bitte verbinde dich mit einem NAO"), findsOneWidget);
  });

  testWidgets('Button is pressed and triggers navigation after tapped',
      (tester) async {
    await tester.pumpWidget(widget);

    expect(find.byType(ElevatedButton), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.byType(CreateConnectPage), findsOneWidget);
  });

  testWidgets('Add connection as Listelement', (tester) async {
    await tester.pumpWidget(widget);

    Builder(
      builder: (BuildContext context) {
        final robotProvider =
            Provider.of<RobotProvider>(context, listen: false);
        robotProvider.addRobot(RobotModel(ipAddress: "123"));
        expect(find.text("Verbundene NAO's"), findsOneWidget);

        expect(find.text("123"), findsOneWidget);

        return const Placeholder();
      },
    );
  });
}
