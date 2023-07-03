import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/robot_provider.dart';
import '../models/robot_model.dart' show Enum;

import '../ui_elements/info_card.dart';

class SpeakerView extends StatefulWidget {
  const SpeakerView({Key? key}) : super(key: key);

  @override
  State<SpeakerView> createState() => _SpeakerViewState();
}

class _SpeakerViewState extends State<SpeakerView> {
  final TextEditingController _speakController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Enum? languageEnum = Enum(
      items: ['German', 'Japanese', 'Chinese', 'English'],
      selectedItem: 'German');
  Enum? voiceEnum = Enum(
      items: ["Julia22Enhanced", "maki_n16", "naoenu", "naomnc"],
      selectedItem: "Julia22Enhanced");
  int volumeValue = 50;

  @override
  Widget build(BuildContext context) {
    final robotProvider = Provider.of<RobotProvider>(context, listen: false);
    final activeRobots = robotProvider.activeItems;

    void showAlertDialog() {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Wähle einen NAO aus"),
              content: const Text(
                  "Damit du den NAO steuern kannst, wähle bitte einen NAO aus"),
              actions: <Widget>[
                OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK"))
              ],
            );
          });
    }

    Future<void> languageHandler(String lng) async {
      if (activeRobots.isEmpty) {
        showAlertDialog();
        return;
      }

      setState(() {
        languageEnum?.selectedItem = lng;
      });

      Object languageObject = {
        'language': lng,
      };
      for (int i = 0; i < activeRobots.length; i++) {
        await activeRobots[i].setLanguage(languageObject);
      }
    }

    Future<void> voiceHandler(String lng) async {
      if (activeRobots.isEmpty) {
        showAlertDialog();
        return;
      }

      setState(() {
        voiceEnum?.selectedItem = lng;
      });

      Object voiceObject = {
        'voice': lng,
      };

      for (int i = 0; i < activeRobots.length; i++) {
        await activeRobots[i].setVoice(voiceObject);
      }
    }

    Future<void> volumeHandler(double vol) async {
      if (activeRobots.isEmpty) {
        showAlertDialog();
        return;
      }

      setState(() {
        volumeValue = vol.toInt();
      });

      Object volumeObject = {
        'volume': vol,
      };
      for (int i = 0; i < activeRobots.length; i++) {
        await activeRobots[i].setVolume(volumeObject);
      }
    }

    Future<void> saySomething() async {
      if (activeRobots.isEmpty) {
        showAlertDialog();
        return;
      }

      String textToSpeak = _speakController.text;

      Map<String, String> audioObject = {
        'text': textToSpeak,
      };
      for (int i = 0; i < activeRobots.length; i++) {
        await activeRobots[i].saySomething(audioObject);
      }
      _speakController.clear();
    }

/*
    Future<void> getVolume() async {
      int volume = await activeRobots[0].getVolume();
      setState(() {
        this.volumeValue = volume;
      });
    }
    Future<void> getLanguage() async {
      Enum languageEnum = await activeRobots[0].getLanguage();
      setState(() {
        this.languageEnum = languageEnum;
      });
    }

    Future<void> getVoice() async {
      Enum voiceEnum = await activeRobots[0].getVoice();
      setState(() {
        this.voiceEnum = voiceEnum;
      });
    }
*/
    return SingleChildScrollView(
      child: Column(
        children: [
          const InfoCard(
            title: "Lass den NAO Sprechen",
            description:
                "Wähle deine bevorzugte Sprache oder schreibe was dein NAO sagen soll",
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sprache",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton(
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
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Stimme",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton(
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
                ],
              )
            ],
          ),
          const Headline(title: "Lautstärke"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
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
                  },
                )),
                const Icon(Icons.volume_up),
              ],
            ),
          ),
          const Headline(title: "Textausgabe"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _speakController,
              decoration: const InputDecoration(
                  filled: true,
                  hintText: "Was soll dein NAO sagen",
                  fillColor: Color(0xfffef7ff)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: SizedBox(
              width: 120,
              height: 40,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ))),
                  onPressed: saySomething,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(Icons.chat_bubble_outline),
                      Text("Sag es")
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class Headline extends StatelessWidget {
  final String title;

  const Headline({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
