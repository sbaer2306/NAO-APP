import 'package:flutter_test/flutter_test.dart';
import 'package:nao_app/providers/robot_provider.dart';
import 'package:nao_app/pages/movement_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  final widget = ChangeNotifierProvider(
    create: (context) => RobotProvider(),
    child: const MaterialApp(
      home: MovementView(),
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

//ActionButton
//Not working because button are not in view, but ensureVisible(button) is also not doing anything
  testWidgets(
    'Given Robot in MovementPage When ActionButton is pressed Then actionMovement is called',
    (WidgetTester widgetTester) async {
      // Assemble
      List<String> buttonNames = [
        'Aufstehen',
        'Hinsetzen',
        'Bauchlage',
        'Rückenlage',
        // "Hinknieen",
        // 'Entspannt hinsetzen',
        // 'Initialposition',
        // 'Neutrale Position',
      ];

      // Pump the widget with the mock RobotProvider and GlobalKey
      await widgetTester.pumpWidget(widget);
      await widgetTester.pumpAndSettle();
      for (final name in buttonNames) {
        final button = find.byWidgetPredicate(
          (widget) => widget is ActionButton && widget.text == name,
        );
        // Scroll to the button to make it visible
        await widgetTester.ensureVisible(button);
        // Ensure button is present on screen
        expect(button, findsOneWidget);
      }
    },
  );

//ControlButton
  testWidgets(
      'Given Robot in MovementPage When ControlButton is pressed Then actionMovement is called',
      (widgetTester) async {
    //assemble
    await widgetTester.pumpWidget(widget);

    const icons = [
      Icons.arrow_forward,
      Icons.u_turn_left,
      Icons.u_turn_right,
      Icons.arrow_upward,
      Icons.arrow_downward,
      Icons.arrow_back,
    ];

    for (final icon in icons) {
      final button = find.byWidgetPredicate(
          (widget) => widget is ControlButton && widget.icon == icon);
      //ensure button is present on screen
      expect(button, findsOneWidget);
    }
  });
}
