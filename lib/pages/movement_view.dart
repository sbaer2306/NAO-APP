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
    'Entspannt hinsetzen',
    'Initialposition',
    'Neutrale Position',
  ];

  String translateMovement(String movement) {
    switch (movement) {
      case 'Aufstehen':
        movement = 'Stand';
        break;
      case 'Hinsetzen':
        movement = 'Sit';
        break;
      case 'Bauchlage':
        movement = 'LyingBelly';
        break;
      case 'Rückenlage':
        movement = 'LyingBack';
        break;
      case 'Entspannt hinsetzen':
        movement = 'SitRelax';
        break;
      case 'Initialposition':
        movement = 'StandInit';
        break;
      case 'Neutrale Position':
        movement = 'StandZero';
        break;
    }

    return movement;
  }

  @override
  Widget build(BuildContext context) {
    final robotProvider = Provider.of<RobotProvider>(context, listen: false);
    final activeRobots = robotProvider.activeItems;
    bool isMoving = false;
    bool isTajChiEnabled = false;

    void showAlertDialog() {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Wähle einen NAO aus"),
              content: const Text(
                  "Damit du den NAO steuern kannst, wähle bitte einen NAO aus"),
              actions: <Widget>[
                OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK"))
              ],
            );
          });
    }

    Future<void> actionMovement(String movement) async {
      String translatedMovement = translateMovement(movement);

      if (activeRobots.isEmpty) {
        showAlertDialog();
        return;
      }

      for (int i = 0; i < activeRobots.length; i++) {
        activeRobots[i].setPosture(translatedMovement);
      }
    }

    Future<void> toggleTajChi() async {
      if (activeRobots.isEmpty) {
        showAlertDialog();
        return;
      }

      for (int i = 0; i < activeRobots.length; i++) {
        isTajChiEnabled =
            robotProvider.getTajChiState(activeRobots[i].ipAddress);

        await activeRobots[i].handleTajChi(isTajChiEnabled);

        robotProvider.toggleTajChi(activeRobots[i].ipAddress);
      }
    }

    Future<void> controlMovement(String direction) async {
      if (activeRobots.isEmpty && direction != "Stop") {
        showAlertDialog();
        return;
      }

      print(direction);

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
        try{
          isMoving = true;
          for (int i = 0; i < activeRobots.length; i++) {
            activeRobots[i].move(moveObject);
          }
        }catch(error){}
        finally{
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
      Center(
        child: SizedBox(
          height: 50,
          width: 200,
          child: ElevatedButton(
            onPressed: toggleTajChi,
            child: const Text(
              'Taj Chi',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
      ),
      SizedBox(
          width: double.infinity,
          child: Container(
              padding: const EdgeInsets.only(left: 20.0, top: 10.0),
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
          const SizedBox(width: 10.0),
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
          const SizedBox(width: 10.0),
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
  // ignore: library_private_types_in_public_api
  _ControlButtonState createState() => _ControlButtonState();
}

class _ControlButtonState extends State<ControlButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: GestureDetector(
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
    ));
  }
}
