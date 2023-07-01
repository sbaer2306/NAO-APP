import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nao_app/models/robot_model.dart';

class RobotProvider extends ChangeNotifier {
  final List<RobotModel> _items = [];
  final List<RobotModel> _activeItems = [];

  Map<String, bool> toggleStates = {};
  Map<String, bool> tajChiStates = {};

  UnmodifiableListView<RobotModel> get items => UnmodifiableListView(_items);
  UnmodifiableListView<RobotModel> get activeItems =>
      UnmodifiableListView(_activeItems);

  bool addRobot(RobotModel newRobot) {
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].ipAddress == newRobot.ipAddress) {
        return false;
      }
    }

    _items.add(newRobot);
    toggleStates[newRobot.ipAddress] = false;
    tajChiStates[newRobot.ipAddress] = false;
    notifyListeners();
    return true;
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
