import 'package:flutter/material.dart';
import 'package:nao_app/api/robot_api_interface.dart';
import '../ui_elements/info_card.dart';
import '../models/robot_model.dart';

import 'dart:developer';

class MovementView extends StatefulWidget {
  const MovementView({Key? key}) : super(key: key);

  @override
  MovementViewState createState() => MovementViewState();
}

class MovementViewState extends State<MovementView> {
  late RobotInterface _robot;

  @override
  void initState() {
    super.initState();
    _robot = RobotModel(ipAddress: '192.168.1.100', name: 'NAO');
  }

  Future<void> actionMovement(String movement) async {
    await _robot.setPosture(movement);
  }

  Future<void> controlMovement(String direction) async {
    Map<String, dynamic> moveObject = {
      'enableArmsInWalkAlgorithm': true,
      'xCoordinate': '0',
      'yCoordinate': '0',
      'tCoordinate': '0',
      'speed': 1.0
    };

    if (direction == 'Twist Left') moveObject['tCoordinate'] = 1.0;
    if (direction == 'Forward') moveObject['xCoordinate'] = 1.0;
    if (direction == 'Twist Right') moveObject['tCoordinate'] = -1.0;
    if (direction == 'Left') moveObject['yCoordinate'] = 1.0;
    if (direction == 'Backward') moveObject['xCoordinate'] = -1.0;
    if (direction == 'Right') moveObject['yCoordinate'] = -1.0;

    await _robot.move(moveObject);
  }

  @override
  Widget build(BuildContext context) {
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
              text: "Stand up", function: () => actionMovement("Standing")),
          ActionButton(
              text: "Sit down", function: () => actionMovement("Sitting")),
          ActionButton(
              text: "Lying Belly",
              function: () => actionMovement("LyingBelly")),
          ActionButton(
              text: "Lying Back", function: () => actionMovement("LyingBack")),
          ActionButton(
              text: "Lying Leftside",
              function: () => actionMovement("LyingLeft")),
          ActionButton(
              text: "Lying Rightside",
              function: () => actionMovement("LyingRight")),
          ActionButton(text: "Back", function: () => actionMovement("Back")),
          ActionButton(text: "Left", function: () => actionMovement("Left")),
          ActionButton(text: "Right", function: () => actionMovement("Right")),
          ActionButton(
              text: "Upside Down",
              function: () => actionMovement("UpsideDown")),
          ActionButton(
              text: "Kneeling", function: () => actionMovement("Kneeling")),
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
                    function: () => controlMovement("Twist left"))),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: SizedBox(
                height: 70.0,
                child: ControlButton(
                    icon: Icons.arrow_upward,
                    function: () => controlMovement("Forward"))),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: SizedBox(
                height: 70.0,
                child: ControlButton(
                    icon: Icons.u_turn_right,
                    function: () => controlMovement("Twist right"))),
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
                  function: () => controlMovement("Left"))),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: SizedBox(
              height: 70.0,
              child: ControlButton(
                  icon: Icons.arrow_downward,
                  function: () => controlMovement("Backward"))),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: SizedBox(
              height: 70.0,
              child: ControlButton(
                  icon: Icons.arrow_forward,
                  function: () => controlMovement("Right"))),
        ),
        const SizedBox(width: 10.0),
      ]))
    ]);
  }
}

//for scrollview, if it would work...
List<ActionButton> buttons = [
  ActionButton(text: "Stand up", function: () => {}),
  ActionButton(text: "Sit down", function: () {}),
  ActionButton(text: "Dance", function: () {}),
  ActionButton(text: "Clap your hands", function: () {}),
  ActionButton(text: "Yoga", function: () {}),
];

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

class ControlButton extends StatelessWidget {
  final IconData icon;
  final Function()? function;

  const ControlButton({super.key, required this.icon, required this.function});

  @override
  Widget build(BuildContext context) {
    return Ink(
        decoration: ShapeDecoration(
          color: Colors.deepPurple[50],
          shape: const StadiumBorder(),
        ),
        child: IconButton(
            iconSize: 30.0,
            onPressed: function,
            style: IconButton.styleFrom(
                backgroundColor: Colors.deepPurple[50],
                shadowColor: Colors.purpleAccent[50],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                minimumSize: const Size(10, 78)),
            icon: Icon(
              icon,
              color: Colors.purple[800],
            )));
  }
}
