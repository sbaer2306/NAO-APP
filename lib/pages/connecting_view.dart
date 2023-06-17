import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:nao_app/ui_elements/info_card.dart';
import 'package:nao_app/providers/robot_provider.dart';
import 'package:nao_app/pages/create_connect_view.dart';
import 'package:nao_app/pages/config_view.dart';

class ConnectView extends StatefulWidget {
  const ConnectView({super.key});

  final String title = "Verbinden";

  @override
  State<ConnectView> createState() => _ConnectViewState();
}

class _ConnectViewState extends State<ConnectView> {
  @override
  Widget build(BuildContext context) {
    final robotProvider = Provider.of<RobotProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
        ),
      ),
      body: Column(
        children: [
          const InfoCard(
              title: "Verwalte deine NAO's",
              description:
                  "Füge neue NAO's hinzu oder entferne bestehende. Wähle einen NAO aus, um seine Konfiguration zu verwalten"),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  robotProvider.items.isEmpty
                      ? "Bitte verbinde dich mit einem NAO"
                      : "Verfügbare NAO's",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                              children: [
                                const Icon(
                                  Icons.smart_toy_outlined,
                                  size: 25,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  robot.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: const Icon(Icons.chevron_right),
                              iconSize: 30,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ConfigView(robot: robot)));
                              },
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
