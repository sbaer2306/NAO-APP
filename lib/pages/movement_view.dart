import 'package:flutter/material.dart';

class MovementView extends StatelessWidget {
  const MovementView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        margin: const EdgeInsets.all(20.0),
        height: 150.0,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.deepPurple[50]),
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
          ActionButton(text: "Stand up", function: () => {}),
          ActionButton(text: "Sit down", function: () {}),
          ActionButton(text: "Dance", function: () {}),
          ActionButton(text: "Clap your hands", function: () {}),
          ActionButton(text: "Yoga", function: () {}),
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
                child:
                    ControlButton(icon: Icons.u_turn_left, function: () => {})),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: SizedBox(
                height: 70.0,
                child: ControlButton(
                    icon: Icons.arrow_upward, function: () => {})),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: SizedBox(
                height: 70.0,
                child: ControlButton(
                    icon: Icons.u_turn_right, function: () => {})),
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
              child: ControlButton(icon: Icons.arrow_back, function: () => {})),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: SizedBox(
              height: 70.0,
              child: ControlButton(
                  icon: Icons.arrow_downward, function: () => {})),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: SizedBox(
              height: 70.0,
              child:
                  ControlButton(icon: Icons.arrow_forward, function: () => {})),
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
