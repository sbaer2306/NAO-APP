import 'package:flutter/material.dart';
import '../ui_elements/nao_background.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int naoCounter = 0;
  var naoConnectings = <IPField>[];
  
  @override
  void initState(){
    super.initState();
    naoConnectings.add(IPField(index: naoCounter));
  }

  void incrementCounter() {
    setState( () {
      naoConnectings.add(IPField(index: naoCounter));
      naoCounter++;
    });
  }

  void decrementCounter() {
    setState( () {
      naoConnectings.removeAt(naoCounter);
      naoCounter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(217, 217, 217, 0),
        centerTitle: true,
        toolbarHeight: 80,
        title: Text(widget.title,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
                decoration: TextDecoration.underline)),
      ),
      body: Container(
        decoration: connectNAO,
        alignment: Alignment.center,
        child: ListView(
          children: <Widget>[
            const Center(
              child: Padding(
                  padding: EdgeInsets.only(top: 40, bottom: 50),
                  child: Text("Stelle eine Verbindung zu den NAO's her",
                      style: TextStyle(
                          color: Color(0xff0d2481),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline))),
            ),
            for (var connecting in naoConnectings) connecting,
            if (naoCounter < 6)
              FloatingActionButton(
                onPressed: incrementCounter,
                backgroundColor: const Color(0xffd9d9d9),
                child: const Icon(Icons.add),
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: decrementCounter,
        tooltip: 'Increment',
        backgroundColor: const Color(0xffd9d9d9),
        child: const Icon(Icons.arrow_forward),
      ),
    ));
  }
}

class IPField extends StatefulWidget {
  final index;

  const IPField({super.key, required this.index});

  @override
  State<IPField> createState() => _IPFieldState();
}

class _IPFieldState extends State<IPField> {
  final TextEditingController _controller = TextEditingController();

  @override 
  void initState() {
    super.initState();
    _controller.text = '192.168.172.';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 60, right: 60),
      child: Row(
        children: <Widget>[
          
          Flexible(
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _controller,
              style: const TextStyle(
                color: Color(0xff0d2481),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(),
                  //hintText: 'Gib hier die IP-Adresse ein',
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
