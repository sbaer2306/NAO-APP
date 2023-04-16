import 'package:flutter/material.dart';
import 'package:nao_app/providers/robot_provider.dart';
import 'package:provider/provider.dart';
import 'my_app.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => RobotProvider(), child: const MyApp()));
}
