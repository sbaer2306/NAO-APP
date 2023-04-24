import 'package:flutter/material.dart';
import 'package:nao_app/ui_elements/info_card.dart';

// TODO: Add data bindings

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const InfoCard(
            title: "Configure your NAO",
            description:
                "Configure your NAO to your needs and preferences. Feel free to play around with the settings and find the best configuration for you."),
        Row(children: const [
          Expanded(
            child: ConfigTitle(title: "Wifi"),
          ),
          Expanded(
            child: ConfigTitle(title: "Battery"),
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
        const ConfigItem(children: [
          Expanded(
            child: TextField(
              decoration:
                  InputDecoration(hintText: "Enter the name for the NAO"),
            ),
          ),
        ]),
        const ConfigTitle(title: "Network Adress"),
        const ConfigItem(children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(hintText: "Enter the IP"),
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
                    const ConfigTitle(title: "Language"),
                    ConfigItem(children: [
                      Expanded(
                        child: DropdownButton(items: const [
                          DropdownMenuItem(
                            value: "english",
                            child: Text("English"),
                          ),
                          DropdownMenuItem(
                            value: "german",
                            child: Text("German"),
                          ),
                          DropdownMenuItem(
                            value: "spanish",
                            child: Text("Spanish"),
                          ),
                          DropdownMenuItem(
                            value: "chineese",
                            child: Text("Chineese"),
                          ),
                        ], onChanged: null, value: "english"),
                      )
                    ])
                  ]),
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ConfigTitle(title: "Voice"),
                    ConfigItem(children: [
                      Expanded(
                        child: DropdownButton(items: const [
                          DropdownMenuItem(
                            value: "male",
                            child: Text("Male"),
                          ),
                          DropdownMenuItem(
                            value: "female",
                            child: Text("Female"),
                          ),
                        ], onChanged: null, value: "male"),
                      )
                    ]),
                  ]),
            )
          ],
        ),
        const ConfigTitle(title: "Volume"),
        const ConfigItem(
          children: [
            Icon(Icons.volume_mute),
            Expanded(
              child: Slider(value: 0, onChanged: null),
            ),
            Icon(Icons.volume_up),
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
                  child: Text("Remove"),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: ElevatedButton(
                onPressed: null,
                child: Text("Save"),
              )),
            ],
          ),
        )
      ],
    ));
  }
}
