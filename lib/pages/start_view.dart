import 'package:flutter/material.dart';
import '../ui_elements/status_bar.dart';
import '../ui_elements/nao_background.dart';

class StartView extends StatefulWidget {
  const StartView({super.key, required this.title});

  final String title;

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  void _forwardToControl() {

  }

  void _forwardToLanguage() {

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: StatusBar(amount: 6),
      body: Container(
        decoration: connectNAO,
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            const Padding(
                padding: EdgeInsets.only(top: 40, bottom: 80),
                child: Text("Hallo",
                    style: TextStyle(
                        color: Color(0xff0d2481),
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                        ))),

            ElevatedButton(
              onPressed: () {
                _forwardToControl();
              },
              child: const Text("Bewegung",
                style: TextStyle(
                color: Color(0xff0d2481),
                fontSize: 20,
                fontWeight: FontWeight.bold
              ))),

            ElevatedButton(
              onPressed: () {
                _forwardToLanguage();
              },
              child:  const Text("Sprache",
                style: TextStyle(
                color: Color(0xff0d2481),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                ))),
            ],
          ),
        ),
      )
    );
  }
}

