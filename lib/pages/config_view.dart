import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:nao_app/models/robot_model.dart';
import 'package:nao_app/providers/robot_provider.dart';
import 'package:nao_app/ui_elements/info_card.dart';
import 'package:provider/provider.dart';

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

class ConfigView extends StatefulWidget {
  const ConfigView({Key? key, required this.robot}) : super(key: key);

  final RobotModel robot;

  @override
  State<StatefulWidget> createState() => _ConfigViewState();
}

class _ConfigViewState extends State<ConfigView> {  
  double batteryValue = 0.5;
  double wifiValue = 0.5;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ipAddressController = TextEditingController();

  double brightnessValue = 0.5;

  Enum? languageEnum = Enum(
      items: ['German', 'Japanese', 'Chinese', 'English'],
      selectedItem: 'German');
  Enum? voiceEnum = Enum(
      items: ["Julia22Enhanced", "maki_n16", "naoenu", "naomnc"],
      selectedItem: "Julia22Enhanced");

  //an Frank: Verwende getVoice / getLanguage wie auch immer es dir passt, habe sie aus der SPrachseite entfernt, also
  //Enum ist nicht notwendig.

  int volumeValue = 50;

  // Getter
  Future<void> getBattery() async {
    setState(() {
      widget.robot.getBattery().then((value) => {
        batteryValue = value
      });
    });
  }

  Future<void> getWifi() async {
    setState(() {
      widget.robot.getWifi().then((value) => {
        wifiValue = value
      });
    });
  }

  Future<void> getBrightness() async {
    setState(() {
      widget.robot.getBrightness().then((value) => {
        brightnessValue = value
      });
    });
  }

  Future<void> getLanguage() async {
    setState(() {
      widget.robot.getLanguage().then((value) => {
        languageEnum = value
    });
    });
  }

  Future<void> getVoice() async {
    setState(() {
      widget.robot.getVoice().then((value) => {
        voiceEnum = value
      });
    });
  }

  Future<void> getVolume() async {
    setState(() {
      widget.robot.getVolume().then((value) => {
        volumeValue = value.toInt()
      });
    });
  }

  // Setter
  Future<void> nameHandler(String name) async {
    setState(() {
      _nameController.text = name;
    });

    widget.robot.setName(name);
  }

  Future<void> ipHandler(String ip) async {
    setState(() {
      _ipAddressController.text = ip;
    });
  }

  Future<void> brightnessHandler(double bri) async {
    setState(() {
      brightnessValue = bri;
    });

    widget.robot.setBrightness(bri);
  }

  Future<void> languageHandler(String lng) async {
      setState(() {
        languageEnum?.selectedItem = lng;
      });

      Object languageObject = {
        'language': lng,
      };
      print("changed language to: $lng");
      
      try {
        await widget.robot.setLanguage(languageObject);
      } catch (error) {
        print("error saying something");
      }
      
    }

  Future<void> voiceHandler(String voice) async {
      setState(() {
        voiceEnum?.selectedItem = voice;
      });

      Object voiceObject = {
        'voice': voice,
      };

      print("changed voice to: $voice");
      
      try {
        await widget.robot.setVoice(voiceObject);
      } catch (error) {
        print("error voice handler");
      }
      
    }

  Future<void> volumeHandler(double vol) async {
      setState(() {
        volumeValue = vol.toInt();
      });

      Object volumeObject = {
        'volume': vol,
      };
      
      try {
        await widget.robot.setVolume(volumeObject);
      } catch (error) {
        print("error volume handler");
      }
      
    }

  @override
  Widget build(BuildContext context) {

    getBattery();
    getWifi();
    _nameController.text = widget.robot.name;
    _ipAddressController.text = widget.robot.ipAddress;
    getBrightness();
    getLanguage();
    getVoice();
    getVolume();    

    return Scaffold(
        appBar: AppBar(title: const Text("Konfiguration")),
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
            ConfigItem(
              children: [
                Icon(Icons.wifi),
                SizedBox(width: 8.0),
                Expanded(
                  child: SizedBox(
                    height: 4.0,
                    child: LinearProgressIndicator(
                      value: wifiValue,
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
                      value: batteryValue,
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
                  controller: _nameController,
                  decoration: const InputDecoration(
                      hintText: "Gib einen Namen für deinen NAO ein"),
                  onSubmitted: (value) {
                    nameHandler(value.toString());
                  },
                ),
              ),
            ]),
            const ConfigTitle(title: "IP Addresse"),
            ConfigItem(children: [
              Expanded(
                child: TextField(
                  controller: _ipAddressController,
                  decoration:
                      const InputDecoration(hintText: "Gib eine IP ein"),
                  readOnly: true,
                  onSubmitted: (value) {
                    ipHandler(value.toString());
                  },
                ),
              ),
            ]),
            const ConfigTitle(title: "Helligkeit"),
            ConfigItem(
              children: [
                const Icon(Icons.lightbulb_outline),
                Expanded(
                  child: Slider(
                      value: brightnessValue,
                      onChanged: (value) {
                        brightnessHandler(value.toDouble());
                      }),
                ),
                const Icon(Icons.lightbulb),
              ],
            ),
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
                                value: languageEnum?.selectedItem ?? '',
                                items: languageEnum != null
                                    ? languageEnum?.items.map((value) {
                                  return DropdownMenuItem(
                                    value: value.toString(),
                                    child: Text(value.toString()),
                                  );
                                }).toList()
                                    : [],
                                onChanged: (value) {
                                  languageHandler(value.toString());
                                },
                            )
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
                                value: voiceEnum?.selectedItem ?? '',
                                items: voiceEnum != null
                                    ? voiceEnum?.items.map((value) {
                                  return DropdownMenuItem(
                                    value: value.toString(),
                                    child: Text(value.toString()),
                                  );
                                }).toList()
                                    : [],
                                onChanged: (value) {
                                  voiceHandler(value.toString());
                                },
                            )
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
                    value: volumeValue.toDouble(),
                    min: 0,
                    max: 100,
                    divisions: 100,
                    onChanged: (value) {
                      volumeHandler(value);
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
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () { 
                          Provider.of<RobotProvider>(context, listen: true).removeRobot(widget.robot);
                          Navigator.pop(context); 
                        },
                      child: Text("Entfernen"),
                    ),
                  ),
                ],
              ),
            )
          ],
        )));
  }
}
