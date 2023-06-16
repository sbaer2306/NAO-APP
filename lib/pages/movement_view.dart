import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/robot_provider.dart';
import '../ui_elements/info_card.dart';

class MovementView extends StatefulWidget {
  const MovementView({Key? key}) : super(key: key);

  @override
  MovementViewState createState() => MovementViewState();
}

class MovementViewState extends State<MovementView> {
  List<String> buttonNames = [
    'Aufstehen',
    'Hinsetzen',
    'Bauchlage',
    'Rückenlage',
    'Links hinlegen',
    'Rechts hinlegen',
    'Umdrehen',
    'Hinknieen'
  ];

  String translateMovement(String movement) {
    //TODO Movements anpassen;

    switch (movement) {
      case 'Aufstehen':
        movement = 'Stand';
        break;
      case 'Hinsetzen':
        movement = 'Sit';
        break;
      case 'Bauchlage':
        movement = 'Stand';
        break;
      case 'Rückenlage':
        movement = 'Stand';
        break;
      case 'Links hinlegen':
        movement = 'Stand';
        break;
      case 'Rechts hinlegen':
        movement = 'Stand';
        break;
      case 'Umdrehen':
        movement = 'Stand';
        break;
      case 'Hinknieen':
        movement = 'Stand';
        break;
      case 'Lifted':
        movement = 'Stand';
        break;
    }

    return movement;
  }

  @override
  Widget build(BuildContext context) {
    final robotProvider = Provider.of<RobotProvider>(context, listen: false);
    final activeRobots = robotProvider.activeItems;
    bool isMoving = false;

    Future<void> actionMovement(String movement) async {
      String translatedMovement = translateMovement(movement);
      try {
        for (int i = 0; i < activeRobots.length; i++) {
          await activeRobots[i].setPosture(translatedMovement);
        }
      } catch (error) {
        print('Error occured: $error');
      }
    }

    Future<void> controlMovement(String direction) async {
      Map<String, dynamic> moveObject = {
        'enableArmsInWalkAlgorithm': true,
        'xCoordinate': '0',
        'yCoordinate': '0',
        'tCoordinate': '0',
        'speed': 1.0
      };

      if (direction == 'Twist left') moveObject['tCoordinate'] = 1.0;
      if (direction == 'Forward') moveObject['xCoordinate'] = 1.0;
      if (direction == 'Twist right') moveObject['tCoordinate'] = -1.0;
      if (direction == 'Left') moveObject['yCoordinate'] = 1.0;
      if (direction == 'Backward') moveObject['xCoordinate'] = -1.0;
      if (direction == 'Right') moveObject['yCoordinate'] = -1.0;
      if (direction == "Stop") {
        moveObject['xCoordinate'] = 0;
        moveObject['yCoordinate'] = 0;
        moveObject['tCoordinate'] = 0;
        moveObject['speed'] = 1.0;
      }

      if (!isMoving) {
        isMoving = true;
        try {
          for (int i = 0; i < activeRobots.length; i++) {
            await activeRobots[i].move(moveObject);
          }
        } catch (error) {
          print('Error occured: $error');
        } finally {
          print("Finally block executed from controlMovement");
          isMoving = false;
        }
      }
    }

    return Column(children: <Widget>[
      const InfoCard(
        title: "Lass den NAO bewegen",
        description:
            "Wähle aus verschieden vorgefertigten Bewegungen oder steuere ihn nach deinem Belieben.",
      ),
      SizedBox(
          width: double.infinity,
          child: Container(
              padding: const EdgeInsets.only(left: 20.0),
              child: const Text(
                "ACTIONS",
                textAlign: TextAlign.start,
                style: TextStyle(color: Color.fromARGB(255, 141, 132, 165)),
              ))),
      SizedBox(
        height: 110,
        width: double.infinity,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          itemCount: buttonNames.length,
          separatorBuilder: (context, index) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            return ActionButton(
              text: buttonNames[index],
              function: () {
                actionMovement(buttonNames[index]);
              },
            );
          },
        ),
      ),
      SizedBox(
          width: double.infinity,
          child: Container(
              padding: const EdgeInsets.only(left: 20.0),
              child: const Text(
                "CONTROLS",
                textAlign: TextAlign.start,
                style: TextStyle(color: Color.fromARGB(255, 141, 132, 165)),
              ))),
      Expanded(
          child: Row(
        children: [
          const SizedBox(width: 10.0),
          Expanded(
            child: SizedBox(
              height: 70.0,
              child: ControlButton(
                icon: Icons.u_turn_left,
                onPressed: () {
                  controlMovement('Twist left');
                },
                onReleased: () {
                  controlMovement('Stop');
                },
              ),
            ),
          ),
          const SizedBox(width: 120.0),
          Expanded(
            child: SizedBox(
              height: 70.0,
              child: ControlButton(
                icon: Icons.u_turn_right,
                onPressed: () {
                  controlMovement('Twist right');
                },
                onReleased: () {
                  controlMovement('Stop');
                },
              ),
            ),
          ),
          const SizedBox(width: 10.0),
        ],
      )),
      Center(
          child: SizedBox(
        height: 70.0,
        width: 120,
        child: ControlButton(
          icon: Icons.arrow_upward,
          onPressed: () {
            controlMovement('Forward');
          },
          onReleased: () {
            controlMovement('Stop');
          },
        ),
      )),
      Expanded(
          child: Row(children: [
        const SizedBox(width: 10.0),
        Expanded(
          child: SizedBox(
            height: 70.0,
            child: ControlButton(
              icon: Icons.arrow_back,
              onPressed: () {
                controlMovement('Left');
              },
              onReleased: () {
                controlMovement('Stop');
              },
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: SizedBox(
            height: 70.0,
            child: ControlButton(
              icon: Icons.arrow_downward,
              onPressed: () {
                controlMovement('Backward');
              },
              onReleased: () {
                controlMovement('Stop');
              },
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: SizedBox(
            height: 70.0,
            child: ControlButton(
              icon: Icons.arrow_forward,
              onPressed: () {
                controlMovement('Right');
              },
              onReleased: () {
                controlMovement('Stop');
              },
            ),
          ),
        ),
        const SizedBox(width: 10.0),
      ]))
    ]);
  }
}

class ActionButton extends StatelessWidget {
  final String text;
  final Function()? function;

  const ActionButton({super.key, required this.text, required this.function});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple[800],
          foregroundColor: Colors.white,
          shadowColor: Colors.purpleAccent,
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          minimumSize: const Size(100, 35)),
      child: Text(text),
    );
  }
}

class ControlButton extends StatefulWidget {
  final IconData icon;
  final Function()? onPressed;
  final Function()? onReleased;

  const ControlButton(
      {super.key,
      required this.icon,
      required this.onPressed,
      required this.onReleased});

  @override
  _ControlButtonState createState() => _ControlButtonState();
}

class _ControlButtonState extends State<ControlButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
          widget.onPressed?.call();
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
          widget.onReleased?.call();
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
          widget.onReleased?.call();
        });
      },
      child: Ink(
        decoration: ShapeDecoration(
          color: _isPressed ? Colors.deepPurple[200] : Colors.deepPurple[50],
          shape: const StadiumBorder(),
        ),
        child: IconButton(
          iconSize: 30.0,
          onPressed: () {},
          style: IconButton.styleFrom(
            backgroundColor:
                _isPressed ? Colors.deepPurple[200] : Colors.deepPurple[50],
            shadowColor: Colors.purpleAccent[50],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            minimumSize: const Size(10, 78),
          ),
          icon: Icon(
            widget.icon,
            color: Colors.purple[800],
          ),
        ),
      ),
    );
  }
}
