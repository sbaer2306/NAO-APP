import 'package:flutter/material.dart';

class MovementView extends StatelessWidget {
  const MovementView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(children: const [
      Spacer(),
      Icon(Icons.toys_outlined),
      SizedBox(width: 20),
      Text("TODO: Add movement controls here"),
      Spacer(),
    ]));
  }
}
