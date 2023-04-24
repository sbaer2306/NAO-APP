import 'package:flutter/material.dart';

class SpeakerView extends StatelessWidget {
  const SpeakerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(children: const [
      Spacer(),
      Icon(Icons.coffee_outlined),
      SizedBox(width: 20),
      Text("TODO: Add speaker controls here"),
      Spacer(),
    ]));
  }
}
