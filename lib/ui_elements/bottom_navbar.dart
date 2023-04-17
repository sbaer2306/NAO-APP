import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: "Damn"),
    ]);
  }
}
