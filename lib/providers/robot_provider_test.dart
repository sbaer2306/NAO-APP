import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nao_app/models/robot_model_test.dart';

class RobotProviderTest extends ChangeNotifier {
  final List<RobotModelTest> _items = [];
  final List<RobotModelTest> _activeItems = [];

  Map<String, bool> toggleStates = {};
  Map<String, bool> tajChiStates = {};

  UnmodifiableListView<RobotModelTest> get items => UnmodifiableListView(_items);
  UnmodifiableListView<RobotModelTest> get activeItems =>
      UnmodifiableListView(_activeItems);

  void addRobot(RobotModelTest newRobot) {
    _items.add(newRobot);
    toggleStates[newRobot.ipAddress] = false;
    tajChiStates[newRobot.ipAddress] = false;
    notifyListeners();
  }

  void addActiveRobot(RobotModelTest activeRobot) {
    _activeItems.add(activeRobot);
    toggleStates[activeRobot.ipAddress] = true;
    notifyListeners();
  }

  void removeRobot(RobotModelTest removeRobot) {
    _items.remove(removeRobot);
    toggleStates.remove(removeRobot.ipAddress);
    notifyListeners();
  }

  void removeActiveRobot(RobotModelTest activeRobot) {
    _activeItems.remove(activeRobot);
    toggleStates[activeRobot.ipAddress] = false;
    notifyListeners();
  }

  void toggleTajChi(String robotIP) {
    bool isTajChiEnabled = !getTajChiState(robotIP);

    tajChiStates[robotIP] = isTajChiEnabled;
    notifyListeners();
  }

  bool getTajChiState(String robotIP) {
    return tajChiStates[robotIP] ?? false;
  }

  bool getToggleState(String robotIP) {
    if (toggleStates.containsKey(robotIP)) {
      return toggleStates[robotIP]!;
    } else {
      return false;
    }
  }
}
