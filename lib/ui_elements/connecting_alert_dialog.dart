import 'package:flutter/material.dart';
import 'package:animated_check/animated_check.dart';

class ConnectingDialog extends StatefulWidget {
  const ConnectingDialog({super.key, required this.code, required this.ip});
  final int code;
  final String ip;

  @override
  State<ConnectingDialog> createState() => _ConnectingDialogState();
}

class _ConnectingDialogState extends State<ConnectingDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutCirc));
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void showCheck() {
    _animationController.forward();
  }

  void resetCheck() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    showCheck();
    return AlertDialog(
        title: widget.code == 200
            ? const Text("Verbindung erfolgreich")
            : const Text("Verbindung fehlgeschlagen"),
        content: widget.code == 200
            ? Row(
                children: [
                  Text(
                      "Sie sind mit dem NAO verbunden\nIP-Adresse: ${widget.ip}"),
                  AnimatedCheck(
                    progress: _animation,
                    size: 100,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              )
            : Text(
                "Es konnte keine Verbindung hergestellt werden. Statuscode: ${widget.code}"),
        actions: <Widget>[
          OutlinedButton(
              onPressed: () {
                resetCheck();
                Navigator.pop(context);
              },
              child: const Text("OK"))
        ]);
  }
}
