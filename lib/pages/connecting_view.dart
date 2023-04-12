import 'package:flutter/material.dart';
import '../ui_elements/nao_background.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int naoCounter = 1;

  void _incrementCounter() {
    setState(() {
      naoCounter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(217, 217, 217, 0),
        centerTitle: true,
        toolbarHeight: 100,
        title: Text(widget.title,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 40,
                decoration: TextDecoration.underline)),
      ),
      body: Container(
        decoration: connectNAO,
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            const Padding(
                padding: EdgeInsets.only(top: 40, bottom: 80),
                child: Text("Stelle eine Verbindung zu den NAO's her",
                    style: TextStyle(
                        color: Color(0xff0d2481),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline))),
            for (var i = 0; i < naoCounter; i++) const IPField(),
            if (naoCounter < 6)
              FloatingActionButton(
                onPressed: _incrementCounter,
                backgroundColor: const Color(0xffd9d9d9),
                child: const Icon(Icons.add),
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.arrow_forward),
      ),
    ));
  }
}

class IPField extends StatelessWidget {
  const IPField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 120, right: 120),
      child: Row(
        children: const <Widget>[
          Flexible(
            child: TextField(
              style: TextStyle(
                color: Color(0xff0d2481),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(),
                  hintText: 'Gib hier die IP-Adresse ein',
                  labelText: 'IP-Adresse',
                  labelStyle: TextStyle(color: Color(0xff0d2481)),
                  fillColor: Color(0xffd9d9d9)),
            ),
          ),
        ],
      ),
    );
  }
}
