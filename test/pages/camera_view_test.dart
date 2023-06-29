import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nao_app/pages/camera_view.dart';
import 'package:nao_app/providers/robot_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

// Create a mock RobotProvider class for testing
class MockRobotProvider extends Mock implements RobotProvider {}

void main() {
  final widget = ChangeNotifierProvider(
    create: (context) => RobotProvider(),
    child: const MaterialApp(
      home: CameraView(),
    ),
  );
  testWidgets(
    'Given CameraView When there are no connected robots Then display "Wähle deine NAO\'s aus"',
    (WidgetTester tester) async {
      await tester.pumpWidget(widget);

      // Expect the "Wähle deine NAO's aus" text to be displayed
      expect(find.text("Wähle deine NAO's aus"), findsOneWidget);
    },
  );

  testWidgets(
    'Given CameraView When toggleView button is pressed Then isPressed state is toggled',
    (WidgetTester tester) async {
      await tester.pumpWidget(widget);

      // Expect the initial state of isPressed to be false
      expect(tester.state<CameraViewState>(find.byType(CameraView)).isPressed,
          false);

      // Find and tap the toggleView button
      await tester.tap(find.byIcon(Icons.power_settings_new));
      await tester.pump();

      // Expect the isPressed state to be toggled to true
      expect(tester.state<CameraViewState>(find.byType(CameraView)).isPressed,
          true);
    },
  );
}
