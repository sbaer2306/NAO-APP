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
          title: "testTitle",
        ),
        navigatorObservers: [mockObserver],
      ));

  testWidgets('The Connecting View has a title', (tester) async {
    await tester.pumpWidget(widget);
    final titleFinder = find.text("testTitle");

    expect(titleFinder, findsOneWidget);
  });

  testWidgets('The List of Connections is empty', (tester) async {
    await tester.pumpWidget(widget);
    expect(
        find.text("Stelle eine Verbinung zu einem NAO her!"), findsOneWidget);
  });

  testWidgets('Button is pressed and triggers navigation after tapped',
      (tester) async {
    await tester.pumpWidget(widget);

    expect(find.byType(FloatingActionButton), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
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
        expect(find.text("Verbundene NAO's: "), findsOneWidget);

        expect(find.text("123"), findsOneWidget);

        return const Placeholder();
      },
    );
  });

  testWidgets('Remove a Listelement and show no connections', (tester) async {
    await tester.pumpWidget(widget);

    Builder(
      builder: (BuildContext context) {
        final robotProvider =
            Provider.of<RobotProvider>(context, listen: false);
        final robotModel = RobotModel(ipAddress: "123");
        robotProvider.addRobot(robotModel);
        expect(find.text("Verbundene NAO's: "), findsOneWidget);
        expect(find.text("123"), findsOneWidget);

        tester.tap(find.byType(IconButton));
        expect(find.text("123"), findsNothing);
        expect(find.text("Stelle eine Verbinung zu einem NAO her!"),
            findsOneWidget);
        return const Placeholder();
      },
    );
  });
}
