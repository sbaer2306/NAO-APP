import 'package:flutter/material.dart';
import 'package:nao_app/api/robot_api_interface.dart';
import 'package:provider/provider.dart';
import '../providers/robot_provider.dart';
import '../ui_elements/info_card.dart';
import '../models/robot_model.dart';

import 'dart:developer';

class MovementView extends StatefulWidget {
  const MovementView({Key? key}) : super(key: key);

  @override
  MovementViewState createState() => MovementViewState();
}

class MovementViewState extends State<MovementView> {
  //late RobotInterface _robot;

/*   @override
  void initState() {
    super.initState();
    _robot = RobotModel(ipAddress: '192.168.171.80', name: 'NAO');
  } */

/*   Future<void> actionMovement(String movement) async {
    try {
      await _robot.setPosture(movement);
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

    try {
      await _robot.move(moveObject);
    } catch (error) {
      print('Error occured: $error');
    }
  } */

  @override
  Widget build(BuildContext context) {
    final robotProvider = Provider.of<RobotProvider>(context, listen: false);
    bool isMoving = false;

    Future<void> actionMovement(String movement) async {
      try {
        await robotProvider.items[0].setPosture(movement);
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
      if (direction == 'Backward') moveObject['xCoordinate'] = 0.0;
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
          await robotProvider.items[0].move(moveObject);
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
      /* scrollable not working?? 
      SizedBox(
        height: 200,
        width: double.infinity,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: const EdgeInsets.all(12),
          itemCount: buttons.length,
          separatorBuilder: (context, index) => const SizedBox(width: 12),
          itemBuilder: (context, index) => buttons[index],
        ),
      ) */
      Wrap(
        spacing: 8.0,
        alignment: WrapAlignment.center,
        children: [
          ActionButton(
              text: "Aufstehen", function: () => actionMovement("Stand")),
          ActionButton(
              text: "Hinsetzen", function: () => actionMovement("Sit")),
          ActionButton(
              text: "Bauchlage", function: () => actionMovement("LyingBelly")),
          ActionButton(
              text: "Rückenlage", function: () => actionMovement("LyingBack")),
          ActionButton(
              text: "Links hinlegen",
              function: () => actionMovement("LyingLeft")),
          ActionButton(
              text: "Rechts hinlegen",
              function: () => actionMovement("LyingRight")),
          ActionButton(text: "Zurück", function: () => actionMovement("Back")),
          ActionButton(text: "Links", function: () => actionMovement("Left")),
          ActionButton(text: "Rechts", function: () => actionMovement("Right")),
          ActionButton(
              text: "Umdrehen", function: () => actionMovement("UpsideDown")),
          ActionButton(
              text: "Hinknieen", function: () => actionMovement("Kneeling")),
          ActionButton(
              text: "Lifted", function: () => actionMovement("Lifted")),
        ],
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
