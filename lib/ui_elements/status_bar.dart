import 'package:flutter/material.dart';
import '../pages/start_view.dart';

class StatusBar extends AppBar {
  final int amount;

  StatusBar({required this.amount})
      : super(
          backgroundColor: const Color.fromRGBO(217, 217, 217, 0),
          title: const Text(
            "NAO-App",
            style: TextStyle(color: Color(0xff0d2481)),
          ),
          elevation: 0.0,
          automaticallyImplyLeading: false,
          bottom: CustomButton(amount: amount),
        );
}

class CustomButton extends StatelessWidget implements PreferredSize {
  const CustomButton({super.key, required this.amount});

  final int amount;

  void _forwardToSingleInformation() {
    print("Test für Single erfolgreich.");
  }

  void _forwardToInformation() {
    print("Test für alle erfolgreich");
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size(100.0, kToolbarHeight),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (int i = 0; i < amount; i++)
              Flexible(
                child: OutlinedButton(
                    onPressed: _forwardToSingleInformation,
                    child: const CustomIcon()),
              ),
            Expanded(
                child: OutlinedButton(
                    onPressed: _forwardToInformation,
                    child: const Icon(Icons.more_vert)))
          ],
        ));
  }

  @override
  Widget get child => const CustomIcon();

  @override
  Size get preferredSize {
    return const Size.fromHeight(30.0);
  }
}

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30.0,
        decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
        child: Column(children: const <Widget>[
          Image(
            image: AssetImage("assets/icons/nao_head.png"),
            fit: BoxFit.cover,
            height: 24.0,
          ),
          LinearProgressIndicator(
            value: 0.5,
            color: Color(0xff00ff00),
          ),
        ]));
  }
}
