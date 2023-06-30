import 'package:flutter/material.dart';
import 'package:nao_app/models/robot_model.dart';
import 'package:nao_app/providers/robot_provider.dart';
import 'package:provider/provider.dart';

class NaoElement extends StatefulWidget {
  const NaoElement({Key? key, required this.robot}) : super(key: key);

  final RobotModel robot;

  @override
  State<StatefulWidget> createState() {
    return _NaoElementState();
  }
}

class _NaoElementState extends State<NaoElement> {
  Icon _icon = const Icon(Icons.add);
  Color? _font = Colors.purple[800];
  Color? _background = Colors.white;
  late bool _toggleState;

  @override
  Widget build(BuildContext context) {
    final robotProvider = Provider.of<RobotProvider>(context, listen: false);
    _toggleState = robotProvider.getToggleState(widget.robot.ipAddress);

    void toggleLayout() {
      _icon = _toggleState
          ? const Icon(
              Icons.check,
              color: Colors.white,
            )
          : const Icon(Icons.add);
      _font = _toggleState ? Colors.white : Colors.purple[800];
      _background = _toggleState ? Colors.purple[800] : Colors.white;
    }

    void activateRobot(RobotModel robot) {
      if (!_toggleState) {
        robotProvider.addActiveRobot(robot);
      } else {
        robotProvider.removeActiveRobot(robot);
      }
      setState(() {
        toggleLayout();
      });
    }

    toggleLayout();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: OutlinedButton(
          onPressed: () {
            activateRobot(widget.robot);
          },
          style: OutlinedButton.styleFrom(
              backgroundColor: _background,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0))),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.robot.name, style: TextStyle(color: _font)),
                _icon
              ])),
    );
  }
}

class NaoListDrawer extends StatelessWidget {
  const NaoListDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var robots = context.watch<RobotProvider>();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
              height: 64.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                ),
                child: const Text('NAO Auswahl zur gleichzeitigen Steuerung'),
              )),
          if (robots.items.isNotEmpty)
            for (int i = 0; i < robots.items.length; i++)
              NaoElement(robot: robots.items[i])
          else
            const Text(
              'Kein NAO vorhanden',
              textAlign: TextAlign.center,
            )
        ],
      ),
    );
  }
}
