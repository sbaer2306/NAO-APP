import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nao_app/models/robot_model.dart';

class RobotProvider extends ChangeNotifier {
  final List<RobotModel> _items = [];
  final List<RobotModel> _activeItems = [];

  Map<String, bool> toggleStates = {};

  UnmodifiableListView<RobotModel> get items => UnmodifiableListView(_items);
  UnmodifiableListView<RobotModel> get activeItems =>
      UnmodifiableListView(_activeItems);

  void addRobot(RobotModel newRobot) {
    _items.add(newRobot);
    toggleStates[newRobot.ipAddress] = false;
    notifyListeners();
  }

  void addActiveRobot(RobotModel activeRobot) {
    _activeItems.add(activeRobot);
    toggleStates[activeRobot.ipAddress] = true;
    notifyListeners();
  }

  void removeRobot(RobotModel removeRobot) {
    _items.remove(removeRobot);
    toggleStates.remove(removeRobot.ipAddress);
    notifyListeners();
  }

  void removeActiveRobot(RobotModel activeRobot) {
    _activeItems.remove(activeRobot);
    toggleStates[activeRobot.ipAddress] = false;
    notifyListeners();
  }

  bool getToggleState(String robotIP) {
    if (toggleStates.containsKey(robotIP)) {
      return toggleStates[robotIP]!;
    } else {
      return false;
    }
  }
}
