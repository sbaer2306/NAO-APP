import 'package:nao_app/providers/robot_provider.dart';
import 'package:test/test.dart';
import 'package:nao_app/models/robot_model.dart';

void main() {
  group('RobotModel Provider', () {
    final provider = RobotProvider();
    test('RobotProvider should start with 0 RobotModels', () {
      expect(provider.items.length, 0);
    });
    test('Add a RobotModel', () {
      provider.addRobot(RobotModel(ipAdress: '123'));
      expect(provider.items.length, 1);
    });
    test('Remove a RobotModel', () {
      final robotModel = RobotModel(ipAdress: "123");
      provider.addRobot(robotModel);
      expect(provider.items.length, 1);

      provider.removeRobot(robotModel);
      expect(provider.items.length, 0);
    });
  });
}
