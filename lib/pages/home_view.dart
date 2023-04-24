import 'package:flutter/material.dart';
import '../ui_elements/status_bar.dart';
import '../ui_elements/nao_background.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.title});

  final String title;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void _forwardToControl() {}

  void _forwardToLanguage() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StatusBar(amount: 6),
      body: Container(
        decoration: connectNAO,
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            const Padding(
                padding: EdgeInsets.only(top: 40, bottom: 80),
                child: Text(
                  "Ciao",
                )),
            ElevatedButton(
                onPressed: () {
                  _forwardToControl();
                },
                child: const Text(
                  "Bewegung",
                )),
            ElevatedButton(
                onPressed: () {
                  _forwardToLanguage();
                },
                child: const Text(
                  "Sprache",
                )),
          ],
        ),
      ),
    );
  }
}
