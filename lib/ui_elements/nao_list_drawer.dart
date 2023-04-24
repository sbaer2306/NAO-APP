import 'package:flutter/material.dart';

class NaoElement extends StatelessWidget {
  const NaoElement({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("TODO: Add NaoElement here"));
  }
}

class NaoListDrawer extends StatelessWidget {
  const NaoListDrawer({Key? key}) : super(key: key);

  VoidCallback onTap(String action, BuildContext context) {
    return () {
      // TODO: Update the state of the app according to $action
      Navigator.pop(context);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            child: Text('Drawer Header'),
          ),
          NaoElement(name: "Red Matter"),
          NaoElement(name: "Lucky Luke"),
          NaoElement(name: "Darth Vader"),
        ],
      ),
    );
  }
}
