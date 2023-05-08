import 'package:flutter/material.dart';

import '../ui_elements/info_card.dart';

class SpeakerView extends StatefulWidget {
  const SpeakerView({Key? key}) : super(key: key);

  @override
  State<SpeakerView> createState() => _SpeakerViewState();
}

class _SpeakerViewState extends State<SpeakerView> {
  final TextEditingController _speakController = TextEditingController();

  double _volume = 0.5;

  void languageHandler(String lng) {}

  void voiceHandler(String lng) {}

  void volumeHandler(double vol) {
    _volume = vol;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const InfoCard(
          title: "Lass den NAO Sprechen",
          description:
              "Wähle deine bevorzugte Sprache oder schreibe was dein NAO sagen soll",
        ),
        const SizedBox(
          height: 70,
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
                  items: const [
                    DropdownMenuItem(
                      value: "Deutsch",
                      child: Text("Deutsch"),
                    ),
                    DropdownMenuItem(
                      value: "Englisch",
                      child: Text("Englisch"),
                    )
                  ],
                  onChanged: (value) {
                    languageHandler(value.toString());
                  },
                  value: "Deutsch",
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
                  items: const [
                    DropdownMenuItem(
                      value: "Männlich",
                      child: Text("Männlich"),
                    ),
                    DropdownMenuItem(
                      value: "Weiblich",
                      child: Text("Weiblich"),
                    )
                  ],
                  onChanged: (value) {
                    voiceHandler(value.toString());
                  },
                  value: "Männlich",
                )
              ],
            )
          ],
        ),
        const Headline(title: "lautstärke"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Icon(Icons.volume_mute),
              Expanded(
                child: Slider(
                    value: _volume,
                    onChanged: (value) {
                      volumeHandler(value);
                    }),
              ),
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
                onPressed: () {},
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
          padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
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
