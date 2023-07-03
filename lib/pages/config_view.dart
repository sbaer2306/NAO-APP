import 'package:flutter/material.dart';
import 'dart:async';
import 'package:nao_app/models/robot_model.dart';
import 'package:nao_app/providers/robot_provider.dart';
import 'package:nao_app/ui_elements/info_card.dart';
import 'package:provider/provider.dart';

/*
void main() {
  RobotModelTest robot = RobotModelTest(name: "Test", ipAddress: "192.168.171.80");

  runApp(MaterialApp(debugShowCheckedModeBanner: false,
      title: 'NAO-App',
      theme: ThemeData(
        primarySwatch:
            Colors.deepPurple, //shade 50 cannot be used due to wrong Type
      ),
      home: ConfigView(robot: robot)));  
}
*/

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

  int brightnessValue = 50;

  Enum? languageEnum = Enum(
      items: ['German', 'Japanese', 'Chinese', 'English'],
      selectedItem: 'German');
  Enum? voiceEnum = Enum(
      items: ["Julia22Enhanced", "maki_n16", "naoenu", "naomnc"],
      selectedItem: "Julia22Enhanced");

  int volumeValue = 50;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getBattery();
      getWifi();
      _nameController.text = widget.robot.name;
      _ipAddressController.text = widget.robot.ipAddress;
      getBrightness();
      //getLanguage();
      //getVoice();
      getVolume();
    });
  }

  // Getter
  Future<void> getBattery() async {
    setState(() {
      widget.robot.getBattery().then((value) => {batteryValue = value});
    });
  }

  Future<void> getWifi() async {
    setState(() {
      widget.robot.getWifi().then((value) => {wifiValue = value});
    });
  }

  Future<void> getBrightness() async {
    setState(() {
      widget.robot.getBrightness().then((value) => {brightnessValue = value});
    });
  }

  /*
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
  */

  Future<void> getVolume() async {
    setState(() {
      widget.robot.getVolume().then((value) => {volumeValue = value.toInt()});
    });
  }

  // Setter
  Future<void> nameHandler(String name) async {
    setState(() {
      widget.robot.setName(name);
      _nameController.text = name;
    });

    
  }

  Future<void> ipHandler(String ip) async {
    setState(() {
      _ipAddressController.text = ip;
    });
  }

  Future<void> brightnessHandler(double bri) async {
    setState(() {
      brightnessValue = bri.toInt();
    });
    
    Object brightnessObject = {
      'brightness': bri,
    };
    
    await widget.robot.setBrightness(brightnessObject);  
  }

  Future<void> languageHandler(String lng) async {
    setState(() {
      languageEnum?.selectedItem = lng;
    });

    Object languageObject = {
      'language': lng,
    };

    await widget.robot.setLanguage(languageObject);
  }

  Future<void> voiceHandler(String voice) async {
    setState(() {
      voiceEnum?.selectedItem = voice;
    });

    Object voiceObject = {
      'voice': voice,
    };

    await widget.robot.setVoice(voiceObject);
  }

  Future<void> volumeHandler(double vol) async {
    setState(() {
      volumeValue = vol.toInt();
    });

    Object volumeObject = {
      'volume': vol,
    };

    await widget.robot.setVolume(volumeObject);
  }

  @override
  Widget build(BuildContext context) {
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
            Row(children: [
              Expanded(
                child: ConfigTitle(title: "Wifi"),
              ),
              Expanded(
                child: ConfigTitle(title: "Akku"),
              ),
            ]),
            ConfigItem(
              children: [
                const Icon(Icons.wifi),
                const SizedBox(width: 8.0),
                Expanded(
                  child: SizedBox(
                    height: 4.0,
                    child: LinearProgressIndicator(
                      value: wifiValue,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                const Icon(Icons.battery_3_bar_outlined),
                const SizedBox(width: 8.0),
                Expanded(
                  child: SizedBox(
                    height: 4.0,
                    child: LinearProgressIndicator(
                      value: batteryValue,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
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
                  controller: _ipAddressController,
                  decoration:
                      const InputDecoration(hintText: "Gib eine IP ein"),
                  readOnly: true,
                ),
              ),
            ]),
            const ConfigTitle(title: "Helligkeit"),
            ConfigItem(
              children: [
                const Icon(Icons.lightbulb_outline),
                Expanded(
                  child: Slider(
                      value: brightnessValue.toDouble(),
                      min: 0,
                      max: 255,
                      divisions: 255,
                      onChanged: (value) {},
                      onChangeEnd: (value) {
                        brightnessHandler(value);
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
                          ))
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
                          ))
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
                      onChanged: (value) {},
                      onChangeEnd: (value) {
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
                        Provider.of<RobotProvider>(context, listen: true)
                            .removeRobot(widget.robot);
                        Navigator.pop(context);
                      },
                      child: const Text("Entfernen"),
                    ),
                  ),
                ],
              ),
            )
          ],
        )));
  }
}
