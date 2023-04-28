import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:nao_app/ui_elements/info_card.dart';
import 'package:nao_app/providers/robot_provider.dart';
import 'package:nao_app/pages/create_connect_view.dart';

class ConnectView extends StatefulWidget {
  const ConnectView({super.key, required this.title});

  final String title;

  @override
  State<ConnectView> createState() => _ConnectViewState();
}

class _ConnectViewState extends State<ConnectView> {
  @override
  Widget build(BuildContext context) {
    final robotProvider = Provider.of<RobotProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffef7ff),
        centerTitle: true,
        toolbarHeight: 80,
        title: Text(widget.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 25,
            )),
      ),
      body: Column(
        children: [
          const InfoCard(
              title: "Verwalte deine NAO's",
              description:
                  "Füge oder entferne deine verschiedenen NAO's, Wählen Sie einen NAO, um seine Konfiguration zu verwalten"),
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text("Verfügbare NAO's"),
              ),
            ],
          ),
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: robotProvider.items.length,
              itemBuilder: (context, index) {
                final robot = robotProvider.items[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    color: const Color(0xfffef7ff),
                    child: SizedBox(
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons.smart_toy_sharp,
                                  size: 40,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Name",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: const Icon(Icons.chevron_right),
                              iconSize: 30,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 140,
        height: 40,
        child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ))),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateConnectPage())).then(
                (value) => setState(() {}),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Icon(Icons.add), Text("hinzufügen")],
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

/* body: Container(
        decoration: connectNAO,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            robotProvider.items.isEmpty
                ? const Text(
                    "Stelle eine Verbinung zu einem NAO her!",
                    style: TextStyle(
                      color: Color(0xff0d2481),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : const Text(
                    "Verbundene NAO's: ",
                    style: TextStyle(
                      color: Color(0xff0d2481),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: robotProvider.items.length,
                itemBuilder: (context, index) {
                  final robot = robotProvider.items[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffd9d9d9),
                        border: Border.all(
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            iconSize: 40,
                            color: const Color(0xff0d2481),
                            onPressed: () {
                              setState(() {
                                robotProvider.removeRobot(robot);
                              });
                            },
                          ),
                          Text(robot.ipAdress,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff0d2481))),
                          const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.check,
                              color: Color(0xff3bccff),
                              size: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
            const SizedBox(
              height: 20,
            ),
            if (robotProvider.items.length < 6)
              FloatingActionButton(
                heroTag: 'add_robot_btn',
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreateConnectPage()))
                      .then(
                    (value) => setState(() {}),
                  );
                },
                backgroundColor: const Color(0xff0d2481),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: robotProvider.items.isEmpty
          ? const Text(
              "Um fortzuführen bitte zuerst eine Verbindung herstellen...",
              style: TextStyle(fontWeight: FontWeight.bold))
          : FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        // TODO: Instead of pushnig to the nav stack we should seek
                        // a solution where we can replace the current view with the home view
                        builder: (context) => const HomeView(
                              title: "NAO-App",
                            )));
              },
              backgroundColor: const Color(0xffd9d9d9),
              child: const Icon(Icons.arrow_forward),
            ),
    ); */