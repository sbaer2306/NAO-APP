import 'package:flutter/material.dart';
import 'package:nao_app/providers/robot_provider.dart';
import 'package:provider/provider.dart';

class NaoElement extends StatefulWidget {
  const NaoElement({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  State<StatefulWidget> createState() {
    return _NaoElementState();
  }
}

class _NaoElementState extends State<NaoElement> {  
  bool _toggle = false;
  Icon _icon = const Icon(Icons.add);
  Color? _font = Colors.purple[800];
  Color? _background = Colors.white;


  void toggleLayout() {
    setState(() {
      _toggle = !_toggle;
      _icon = _toggle ? const Icon(Icons.check, color: Colors.white,) : const Icon(Icons.add);
      _font = _toggle ? Colors.white : Colors.purple[800];
      _background = _toggle ? Colors.purple[800] : Colors.white;
    });
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton (
        onPressed: toggleLayout,
        style: OutlinedButton.styleFrom(
          backgroundColor: _background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          )
        ),
        child: Row (
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.name, style: TextStyle(color: _font)),
            _icon
          ]
        )
    );
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
            )
          ),
          if (robots.items.isNotEmpty)
            for (int i = 0; i < robots.items.length; i++)
              NaoElement(name: robots.items[i].name)
          else
            const Text('Kein NAO vorhanden', textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}
