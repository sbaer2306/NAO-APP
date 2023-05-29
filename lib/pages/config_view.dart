import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:nao_app/ui_elements/info_card.dart';

class ConfigItem extends StatelessWidget {
  const ConfigItem({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Row(
          children: children,
        ));
  }
}

class ConfigTitle extends StatelessWidget {
  const ConfigTitle({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class ConfigView extends StatelessWidget {
  const ConfigView({Key? key}) : super(key: key);

  Future<void> nameHandler(String name) async {
    var url = Uri.https('httpbin.org', 'post');
    var response = await http.post(url, body: {'type': 'Name', 'value': name});

    var statusCode = response.statusCode;
    if (kDebugMode) {
      print(statusCode);
      if (statusCode == 200) {
        print("Derzeitiger Name: $name");
      }
    }
  }

  Future<void> ipHandler(String ip) async {
    var url = Uri.https('httpbin.org', 'post');
    var response =
        await http.post(url, body: {'type': 'IP-Adresse', 'value': ip});

    var statusCode = response.statusCode;
    if (kDebugMode) {
      print(statusCode);
      if (statusCode == 200) {
        print("Derzeitige IP-Adresse: $ip");
      }
    }
  }

  Future<void> languageHandler(String lng) async {
    var url = Uri.https('httpbin.org', 'post');
    var response =
        await http.post(url, body: {'type': 'Language', 'value': lng});

    var statusCode = response.statusCode;
    if (kDebugMode) {
      print(statusCode);
      if (statusCode == 200) {
        print("Derzeitige Sprache: $lng");
      }
    }
  }

  Future<void> voiceHandler(String lng) async {
    var url = Uri.https('httpbin.org', 'post');
    var response = await http.post(url, body: {'type': 'Voice', 'value': lng});

    var statusCode = response.statusCode;
    if (kDebugMode) {
      print(statusCode);
      if (statusCode == 200) {
        print("Derzeitige Stimme: $lng");
      }
    }
  }

  Future<void> volumeHandler(double vol) async {
    var url = Uri.https('httpbin.org', 'post');
    var response =
        await http.post(url, body: {'type': 'Voice', 'value': vol.toString()});

    var statusCode = response.statusCode;
    if (kDebugMode) {
      print(statusCode);
      if (statusCode == 200) {
        print("Derzeitige Stimmenlautstärke: $vol");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Konfiguration")),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const InfoCard(
                title: "Konfiguriere deinen NAO",
                description:
                    "Konfugiere deinen NAO nach deinen Wünschen und Vorlieben. Du kannst gerne mit den Einstellungen herumspielen und die beste Konfiguration für dich finden."),
            Row(children: const [
              Expanded(
                child: ConfigTitle(title: "Wifi"),
              ),
              Expanded(
                child: ConfigTitle(title: "Akku"),
              ),
            ]),
            const ConfigItem(
              children: [
                Icon(Icons.wifi),
                SizedBox(width: 8.0),
                Expanded(
                  child: SizedBox(
                    height: 4.0,
                    child: LinearProgressIndicator(
                      value: .6,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Icon(Icons.battery_3_bar_outlined),
                SizedBox(width: 8.0),
                Expanded(
                  child: SizedBox(
                    height: 4.0,
                    child: LinearProgressIndicator(
                      value: .6,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Divider(
                color: Colors.grey.shade400,
              ),
            ),
            const ConfigTitle(title: "Name"),
            ConfigItem(children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                      hintText: "Gib einen Namen für deinen NAO ein"),
                  onChanged: (value) {
                    nameHandler(value.toString());
                  },
                ),
              ),
            ]),
            const ConfigTitle(title: "IP Addresse"),
            ConfigItem(children: [
              Expanded(
                child: TextField(
                  decoration:
                      const InputDecoration(hintText: "Gib eine IP ein"),
                  onChanged: (value) {
                    ipHandler(value.toString());
                  },
                ),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ConfigTitle(title: "Sprache"),
                        ConfigItem(children: [
                          Expanded(
                            child: DropdownButton(
                                items: const [
                                  DropdownMenuItem(
                                    value: "english",
                                    child: Text("Englisch"),
                                  ),
                                  DropdownMenuItem(
                                    value: "german",
                                    child: Text("Deutsch"),
                                  ),
                                  DropdownMenuItem(
                                    value: "spanish",
                                    child: Text("Spanisch"),
                                  ),
                                  DropdownMenuItem(
                                    value: "chineese",
                                    child: Text("Chinesisch"),
                                  ),
                                ],
                                onChanged: (value) {
                                  languageHandler(value.toString());
                                },
                                value: "english"),
                          )
                        ])
                      ]),
                ),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ConfigTitle(title: "Stimme"),
                        ConfigItem(children: [
                          Expanded(
                            child: DropdownButton(
                                items: const [
                                  DropdownMenuItem(
                                    value: "male",
                                    child: Text("Männlich"),
                                  ),
                                  DropdownMenuItem(
                                    value: "female",
                                    child: Text("Weiblich"),
                                  ),
                                ],
                                onChanged: (value) {
                                  voiceHandler(value.toString());
                                },
                                value: "male"),
                          )
                        ]),
                      ]),
                )
              ],
            ),
            const ConfigTitle(title: "Lautstärke"),
            ConfigItem(
              children: [
                const Icon(Icons.volume_mute),
                Expanded(
                  child: Slider(
                      value: 0,
                      onChanged: (value) {
                        volumeHandler(value.toDouble());
                      }),
                ),
                const Icon(Icons.volume_up),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: const [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: null,
                      child: Text("Entfernen"),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: ElevatedButton(
                    onPressed: null,
                    child: Text("Speichern"),
                  )),
                ],
              ),
            )
          ],
        )));
  }
}
