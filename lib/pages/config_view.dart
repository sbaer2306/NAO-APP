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

  var languageValues = <String>[];
  String languageValue = "German";

  var voiceValues = <String>[];
  String voiceValue = "naoenu";

  double volumeValue = 0.5;

  @override
  void initState() {
    super.initState();
    
    getBattery();
    getWifi();
    _nameController.text = widget.robot.name;
    _ipAddressController.text = widget.robot.ipAddress;
    getBrightness();
    getLanguage();
    getVoice();
    getVolume();    
  }

  // Getter
  Future<void> getBattery() async {
    var ipAddress = widget.robot.ipAddress;
    var url = Uri.http('$ipAddress:8080', '/api/config/battery');
    var response = await http.get(Uri.parse(url.toString()));
    
    if (response.statusCode == 200) {
      setState(() {
        batteryValue = double.parse(response.body) / 100.0;
      });
    }
  }

  Future<void> getWifi() async {
    var ipAddress = widget.robot.ipAddress;
    var url = Uri.http('$ipAddress:8080', '/api/config/wifi_strength');
    var response = await http.get(Uri.parse(url.toString()));
    
    if (response.statusCode == 200) {
      setState(() {
        wifiValue = double.parse(response.body) / 100.0;
      });
    }
  }

  Future<void> getBrightness() async {
    var ipAddress = widget.robot.ipAddress;

    var url = Uri.http('$ipAddress:8080', '/api/vision/brightness');
    var response = await http.get(Uri.parse(url.toString()));
    
    if (response.statusCode == 200) {
      setState(() {
        brightnessValue = double.parse(response.body) / 255.0;
      });
    }
  }

  Future<void> getLanguage() async {
    var ipAddress = widget.robot.ipAddress;

    var url = Uri.http('$ipAddress:8080', '/api/audio/language');
    var response = await http.get(Uri.parse(url.toString()));
    
    if (response.statusCode == 200) {
      setState(() {
        languageValues = response.body.split(',');
        
        if (widget.robot.language == "") {
          languageValue = languageValues[0];
        }
        else {
          languageValue = widget.robot.language;
        }
      });
    }
  }

  Future<void> getVoice() async {
    var ipAddress = widget.robot.ipAddress;

    var url = Uri.http('$ipAddress:8080', '/api/audio/voice');
    var response = await http.get(Uri.parse(url.toString()));
    
    if (response.statusCode == 200) {
      setState(() {
        voiceValues = response.body.split(',');
        
        if (widget.robot.voice == "") {
          voiceValue = voiceValues[0];
        }
        else {
          voiceValue = widget.robot.voice;
        }
        
      });
    }
  }

  Future<void> getVolume() async {
    var ipAddress = widget.robot.ipAddress;

    var url = Uri.http('$ipAddress:8080', '/api/audio/volume');
    var response = await http.get(Uri.parse(url.toString()));
    
    if (response.statusCode == 200) {
      setState(() {
        volumeValue = double.parse(response.body) / 100.0;
      });
    }
  }

  // Setter
  Future<void> nameHandler(String name) async {
    setState(() {
      _nameController.text = name;
    });

    widget.robot.name = name;
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

    var ipAddress = widget.robot.ipAddress;
    var url = Uri.http('$ipAddress:8080', '/api/vision/brightness');
    var headers = {"Content-type": "application/json"};
    var response =
        await http.post(url, headers:headers, body: {'type': 'object', 'brightness': int.parse((bri * 255.0).toString())});

    if (response.statusCode == 200) {
        // print("Derzeitige Stimmenlautstärke: $vol");
    }
  }

  Future<void> languageHandler(String lng) async {
    setState(() {
      languageValue = lng;
    });

    var ipAddress = widget.robot.ipAddress;
    var url = Uri.http('$ipAddress:8080', '/api/audio/language');
    var headers = {"Content-type": "application/json"};
    var response = await http.post(url, headers:headers, body: {'type': 'object', 'language': lng});

    if (response.statusCode == 200) {
        // print("Derzeitige Sprache: $lng");
    }
  }

  Future<void> voiceHandler(String lng) async {
    setState(() {
      voiceValue = lng;
    });

    var ipAddress = widget.robot.ipAddress;
    var url = Uri.http('$ipAddress:8080', '/api/audio/voice');
    var headers = {"Content-type": "application/json"};
    var response = await http.post(url, headers:headers, body: {'type': 'object', 'language': lng});

    if (response.statusCode == 200) {
        // print("Derzeitige Sprache: $lng");
    }
  }

  Future<void> volumeHandler(double vol) async {
    setState(() {
      volumeValue = vol;
    });

    var ipAddress = widget.robot.ipAddress;
    var url = Uri.http('$ipAddress:8080', '/api/audio/volume');
    var headers = {"Content-type": "application/json"};
    var response =
        await http.post(url, headers:headers, body: {'type': 'object', 'volume': int.parse((vol * 100.0).toString())});

    if (response.statusCode == 200) {
        // print("Derzeitige Stimmenlautstärke: $vol");
      }
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
                const Icon(Icons.lightbulb),
                Expanded(
                  child: Slider(
                      value: brightnessValue,
                      onChanged: (value) {
                        brightnessHandler(value.toDouble());
                      }),
                ),
                const Icon(Icons.volume_up),
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
                                items: languageValues.map((d) {
                                  return DropdownMenuItem(value: d, child: Text(d));
                                }).toList(),
                                onChanged: (value) {
                                  languageHandler(value.toString());
                                },
                                value: languageValue),
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
                                items: voiceValues.map((d) {
                                  return DropdownMenuItem(value: d, child: Text(d));
                                }).toList(),
                                onChanged: (value) {
                                  voiceHandler(value.toString());
                                },
                                value: voiceValue),
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
                      value: volumeValue,
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
