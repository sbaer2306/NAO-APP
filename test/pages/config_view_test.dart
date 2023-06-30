import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nao_app/models/robot_model_test.dart';
import 'package:nao_app/providers/robot_provider_test.dart';
import 'package:nao_app/ui_elements/info_card.dart';
import 'package:provider/provider.dart';

void main() {

  //RobotModelTest robot = RobotModelTest(ipAddress: "192.168.171.80", name: "Test");

  testWidgets('Widget Test for status indicators', (widgetTester) async {
    await widgetTester.pumpWidget(const ConfigItem(children: [
                Icon(Icons.wifi, textDirection: TextDirection.ltr),
                SizedBox(width: 8.0),
                Expanded(
                  child: SizedBox(
                    height: 4.0,
                    child:
                      LinearProgressIndicator(
                      key: Key('Wifi'),
                      value: 0.5,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Icon(Icons.battery_3_bar_outlined, textDirection: TextDirection.ltr),
                SizedBox(width: 8.0),
                Expanded(
                  child: SizedBox(
                    height: 4.0,
                    child:
                      LinearProgressIndicator(
                        key: Key('Battery'),
                        value: 0.5,
                    )),
                  ),
                
                SizedBox(width: 8.0),
              ],));
    
    final wifiFinder = find.byKey(const Key('Wifi'));
    expect(wifiFinder, findsOneWidget);

    final batteryFinder = find.byKey(const Key('Battery'));
    expect(batteryFinder, findsOneWidget);
  });

  testWidgets("Widget Test for Name textfield", (widgetTester) async {
      final TextEditingController nameController = TextEditingController();

      void nameHandler(String name) {
        nameController.text = name;
      }

      await widgetTester.pumpWidget(ConfigItem(children: [
              Expanded(
                child: Localizations(
                  locale: const Locale('en', 'US'),
                  delegates: const <LocalizationsDelegate<dynamic>>[DefaultWidgetsLocalizations.delegate, DefaultMaterialLocalizations.delegate,],
                    child: Material(
                      child: TextField(
                        key: const Key("Name"),
                        controller: nameController,
                        decoration: const InputDecoration(
                            hintText: "Gib einen Namen für deinen NAO ein"),
                        onSubmitted: (value) {
                          nameHandler(value.toString());
                      },
                    ),
                  ),
                )
              )
        ]));

        final nameFinder = find.byKey(const Key('Name'));
        expect(nameFinder, findsOneWidget);
    });

    testWidgets("Widget Test for IP textfield", (widgetTester) async {
      final TextEditingController ipAddressController = TextEditingController();

      void ipHandler(String name) {
        ipAddressController.text = name;
      }

      await widgetTester.pumpWidget(ConfigItem(children: [
              Expanded(
                child: Localizations(
                  locale: const Locale('en', 'US'),
                  delegates: const <LocalizationsDelegate<dynamic>>[DefaultWidgetsLocalizations.delegate, DefaultMaterialLocalizations.delegate,],
                    child: Material(
                      child: TextField(
                        key: const Key("IP"),
                        controller: ipAddressController,
                        decoration: const InputDecoration(
                            hintText: "Gib eine IP ein"),
                        onSubmitted: (value) {
                          ipHandler(value.toString());
                      },
                    ),
                  ),
                )
              )
        ]));

        final nameFinder = find.byKey(const Key('IP'));
        expect(nameFinder, findsOneWidget);
    });

    testWidgets('Widget Test for brightness slider', (widgetTester) async {
    
    double brightnessValue = 0.5;

    void brightnessHandler(double value) {
        brightnessValue = value;
    }
    
    await widgetTester.pumpWidget(ConfigItem(children: [
      const Icon(Icons.lightbulb_outline, textDirection: TextDirection.ltr),
      Expanded(
        child: Material(
          child: Slider(
            key: const Key("Brightness"),
            value: brightnessValue,
            onChanged: (value) {
              brightnessHandler(value.toDouble());
            })),
      ),
      const Icon(Icons.lightbulb, textDirection: TextDirection.ltr),
    ],));
    
    final brightnessFinder = find.byKey(const Key('Brightness'));
    expect(brightnessFinder, findsOneWidget);
  });

  testWidgets('Widget Test for language dropdown menu', (widgetTester) async {
    
    Enum? languageEnum = Enum(
      items: ['German', 'Japanese', 'Chinese', 'English'],
      selectedItem: 'English');

    void languageHandler(String value) {
        languageEnum.selectedItem = value;
    }

    await widgetTester.pumpWidget(ConfigItem(children: [
      Expanded(
        child: Material(
          child: Localizations(
            locale: const Locale('en', 'US'),
            delegates: const <LocalizationsDelegate<dynamic>>[DefaultWidgetsLocalizations.delegate, DefaultMaterialLocalizations.delegate,],
          child: DropdownButton(
            key: const Key("Language"),
            value: languageEnum.selectedItem,
            items: languageEnum.items.map((value) {
              return DropdownMenuItem(
                value: value.toString(),
                child: Text(value.toString()),
              );
            }).toList(),
            onChanged: (value) {
              languageHandler(value.toString());
            },
          )
        )
      )
     )
    ],));
    
    final brightnessFinder = find.byKey(const Key('Language'));
    expect(brightnessFinder, findsOneWidget);
  });
  
  testWidgets('Widget Test for voice dropdown menu', (widgetTester) async {
    
    Enum? voiceEnum = Enum(
      items: ["Julia22Enhanced", "maki_n16", "naoenu", "naomnc"],
      selectedItem: "Julia22Enhanced");

    void voiceHandler(String value) {
        voiceEnum.selectedItem = value;
    }

    await widgetTester.pumpWidget(ConfigItem(children: [
      Expanded(
        child: Material(
          child: Localizations(
            locale: const Locale('en', 'US'),
            delegates: const <LocalizationsDelegate<dynamic>>[DefaultWidgetsLocalizations.delegate, DefaultMaterialLocalizations.delegate,],
          child: DropdownButton(
            key: const Key("Voice"),
            value: voiceEnum.selectedItem,
            items: voiceEnum.items.map((value) {
              return DropdownMenuItem(
                value: value.toString(),
                child: Text(value.toString()),
              );
            }).toList(),
            onChanged: (value) {
              voiceHandler(value.toString());
            },
          )
        )
      )
     )
    ],));
    
    final brightnessFinder = find.byKey(const Key('Voice'));
    expect(brightnessFinder, findsOneWidget);
  });

  testWidgets('Widget Test for volume slider', (widgetTester) async {
    
    double volumeValue = 0.5;

    void volumeHandler(double value) {
        volumeValue = value;
    }
    
    await widgetTester.pumpWidget(ConfigItem(children: [
      const Icon(Icons.lightbulb_outline, textDirection: TextDirection.ltr),
      Expanded(
        child: Material(
          child: Slider(
            key: const Key("Volume"),
            value: volumeValue.toDouble(),
            min: 0,
            max: 100,
            divisions: 100,
            onChanged: (value) {
              volumeHandler(value);
            })),
      ),
      const Icon(Icons.volume_up, textDirection: TextDirection.ltr),
    ],));
    
    final volumeFinder = find.byKey(const Key('Volume'));
    expect(volumeFinder, findsOneWidget);
  });
}

class ConfigItem extends StatelessWidget {
  const ConfigItem({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Directionality(textDirection: TextDirection.ltr, 
        child: Row(
          children: children,
        )));
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
            textDirection: TextDirection.ltr,
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

class ConfigViewTest extends StatefulWidget {
  const ConfigViewTest({Key? key, required this.robot}) : super(key: key);

  final RobotModelTest robot;

  @override
  State<StatefulWidget> createState() => _ConfigViewState();
}

class _ConfigViewState extends State<ConfigViewTest> {  
  double batteryValue = 0.5;
  double wifiValue = 0.5;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ipAddressController = TextEditingController();

  double brightnessValue = 0.5;

  Enum? languageEnum = Enum(
      items: ['German', 'Japanese', 'Chinese', 'English'],
      selectedItem: 'English');
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

    getBattery();
    getWifi();
    _nameController.text = widget.robot.name;
    _ipAddressController.text = widget.robot.ipAddress;
    getBrightness();
    getLanguage();
    getVoice();
    getVolume();    

    return Scaffold(
        appBar: AppBar(title: const Text("Konfiguration", textDirection: TextDirection.ltr)),
        body: Directionality(textDirection: TextDirection.ltr,
        child:        
        SingleChildScrollView(
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
              key: const Key("Status"),
              children: [
                const Icon(Icons.wifi, textDirection: TextDirection.ltr),
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
                const Icon(Icons.battery_3_bar_outlined, textDirection: TextDirection.ltr),
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
            ConfigItem(
              children: [
              Expanded(
                child: Localizations(
                  locale: const Locale('en', 'US'),
                  delegates: const <LocalizationsDelegate<dynamic>>[DefaultWidgetsLocalizations.delegate, DefaultMaterialLocalizations.delegate,],
                    child: Material(
                      child: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                            hintText: "Gib einen Namen für deinen NAO ein"),
                        onSubmitted: (value) {
                          nameHandler(value.toString());
                        },
                      ),
                    )
                )
              ),
            ]),
            const ConfigTitle(title: "IP Addresse"),
            ConfigItem(
              children: [
              Expanded(
                child: Localizations(
                  locale: const Locale('en', 'US'),
                  delegates: const <LocalizationsDelegate<dynamic>>[DefaultWidgetsLocalizations.delegate, DefaultMaterialLocalizations.delegate,],
                    child: Material(
                      child: TextField(
                        controller: _ipAddressController,
                        decoration:
                            const InputDecoration(hintText: "Gib eine IP ein"),
                        readOnly: true,
                        onSubmitted: (value) {
                          ipHandler(value.toString());
                        },
                      ),
                    )
                )
              ),
            ]),
            const ConfigTitle(title: "Helligkeit"),
            ConfigItem(
              children: [
                const Icon(Icons.lightbulb_outline, textDirection: TextDirection.ltr),
                Expanded(
                  child: Material(
                    child: Slider(
                        value: brightnessValue,
                        onChanged: (value) {
                          brightnessHandler(value.toDouble());
                        }),
                  )
                ),
                const Icon(Icons.lightbulb, textDirection: TextDirection.ltr),
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
                        ConfigItem(
                          children: [
                          Expanded(
                            child: Localizations(
                              locale: const Locale('en', 'US'),
                              delegates: const <LocalizationsDelegate<dynamic>>[DefaultWidgetsLocalizations.delegate, DefaultMaterialLocalizations.delegate,],
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
                          )
                        ])
                      ]),
                ),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ConfigTitle(title: "Stimme"),
                        ConfigItem(
                          children: [
                          Expanded(
                            child: Localizations(
                              locale: const Locale('en', 'US'),
                              delegates: const <LocalizationsDelegate<dynamic>>[DefaultWidgetsLocalizations.delegate, DefaultMaterialLocalizations.delegate,],
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
                          )
                        ]),
                      ]),
                )
              ],
            ),
            const ConfigTitle(title: "Lautstärke"),
            ConfigItem(
              children: [
                const Icon(Icons.volume_mute, textDirection: TextDirection.ltr),
                Expanded(
                  child: Material(
                    child: Slider(
                      value: volumeValue.toDouble(),
                      min: 0,
                      max: 100,
                      divisions: 100,
                      onChanged: (value) {
                        volumeHandler(value);
                      }),
                    )
                  ),
                const Icon(Icons.volume_up, textDirection: TextDirection.ltr),
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
                          Provider.of<RobotProviderTest>(context, listen: true).removeRobot(widget.robot);
                          Navigator.pop(context); 
                        },
                      child: const Text("Entfernen"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ))));
  }
}
