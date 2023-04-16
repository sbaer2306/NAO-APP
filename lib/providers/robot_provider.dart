import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:nao_app/models/robot_model.dart';
//import 'package:nao_app/ui_elements/ip_field.dart';

class RobotProvider extends ChangeNotifier {
  final List<RobotModel> _items = [];

  UnmodifiableListView<RobotModel> get items => UnmodifiableListView(_items);

  void addRobot(RobotModel newRobot) {
    _items.add(newRobot);
    notifyListeners();
  }

  void removeRobot(RobotModel removeRobot) {
    _items.remove(removeRobot);
    notifyListeners();
  }
}
