import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:nao_app/providers/robot_provider.dart';
import 'package:nao_app/ui_elements/info_card.dart';
import 'package:nao_app/pages/movement_view.dart';
import 'package:nao_app/models/robot_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockDio extends Mock implements Dio {}

//Construction:
//Given: some context
//When: some action is carried out
//Then: a particular set of observable consequences should obtain

void main() {
  final mockObserver = MockNavigatorObserver();

  final widget = ChangeNotifierProvider(
    create: (context) => RobotProvider(),
    child: MaterialApp(
      home: const MovementView(),
      navigatorObservers: [mockObserver],
    ),
  );

  test(
      'Given function with String is called When translateMovement ist called Then translation should be',
      () async {
    //arrange
    final movement = MovementViewState();

    final inputOutputPairs = {
      'Aufstehen': 'Stand',
      'Hinsetzen': 'Sit',
      'Bauchlage': 'LyingBelly',
      'Rückenlage': 'LyingBack',
      'Entspannt hinsetzen': 'SitRelax',
      'Initialposition': 'StandInit',
      'Neutrale Position': 'StandZero',
      'Hinknieen': 'Crouch',
    };
    //act and assert
    inputOutputPairs.forEach((input, expectedOutput) {
      final translatedMovement = movement.translateMovement(input);
      expect(translatedMovement, expectedOutput);
    });
  });

  test(
      'Given function with String is called When ActionMovement ist called Then translation should be',
      () async {
    final movement = MovementViewState();
  });
  test(
      'Given function with String is called When ControlMovement ist called Then translation should be',
      () async {
    final movement = MovementViewState();
  });
  test(
      'Given function with String is called When ToggleTajChi ist called Then translation should be',
      () async {
    final movement = MovementViewState();
  });

//WIDGET TESTING

//MovementView
  testWidgets(
      'Given Robot in MovementPage When ActionButton is pressed Then actionMovement is called',
      (widgetTester) async {
    //assemble
    await widgetTester.pumpWidget(widget);

    final button = find.byWidgetPredicate(
        (widget) => widget is ActionButton && widget.text == 'Aufstehen');
    //ensure button is present on screen
    expect(button, findsOneWidget);
    //act
    await widgetTester.tap(button);
    await widgetTester.pump();

    //assert
    //What to look for if fucntion is API call with Future<Void>?
  });

//ActionButton
  testWidgets(
      'Given Robot in MovementPage When ActionButton is pressed Then actionMovement is called',
      (widgetTester) async {
    //assemble
    await widgetTester.pumpWidget(widget);

    final button = find.byWidgetPredicate(
        (widget) => widget is ActionButton && widget.text == 'Aufstehen');
    //ensure button is present on screen
    expect(button, findsOneWidget);
    //act
    await widgetTester.tap(button);
    await widgetTester.pump();

    //assert
    //What to look for if fucntion is API call with Future<Void>?
  });

//ControlButton
  testWidgets(
      'Given Robot in MovementPage When ControlButton is pressed Then controlMovement is called',
      (widgetTester) async => {
            //TODO
          });
}
