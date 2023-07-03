import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nao_app/models/robot_model.dart';
import 'package:nao_app/providers/robot_provider.dart';
import 'package:provider/provider.dart';
import '../ui_elements/info_card.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../ui_elements/connecting_alert_dialog.dart';

class CreateConnectPage extends StatefulWidget {
  const CreateConnectPage({super.key});

  @override
  State<CreateConnectPage> createState() => _CreateConnectPageState();
}

class _CreateConnectPageState extends State<CreateConnectPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ipAddressController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  bool _isLoading = false;
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _ipAddressController.text = '192.168.171.';
  }

  @override
  Widget build(BuildContext context) {
    final robotProvider = Provider.of<RobotProvider>(context, listen: false);

    void showAlertDialog(int code) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return ConnectingDialog(code: code, ip: _ipAddressController.text);
          });
    }

    Future<int> connectToNao(RobotModel robot) async {
      setState(() {
        _isLoading = true;
      });
      bool isInstalled = true;
      print(_isChecked);
      if (_isChecked) {
        print("hallo");
        isInstalled = await robot.installBackendOnNAO(
            _usernameController.text, _pwController.text);
      }

      if (isInstalled) {
        await Future.delayed(const Duration(seconds: 10));
        return robot.connect("9559");
      }
      return 500;
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Neue Verbindung",
          ),
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              children: [
                const InfoCard(
                    title: "Verbinde deinen NAO",
                    description:
                        "Mit Eingabe der IP-Adresse vom NAO kannst du eine Verbindung herstellen. \nOptional kannst du deinem NAO einen Namen geben"),
                const Headline(title: "Nao-Name"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    key: const Key("nameTextField"),
                    controller: _nameController,
                    decoration: const InputDecoration(
                        filled: true,
                        hintText: "Gib hier deinen gewünschten Namen ein",
                        fillColor: Color(0xfffef7ff)),
                  ),
                ),
                const Headline(title: "IP-Adresse"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    key: const Key("ipAddressTextField"),
                    keyboardType: TextInputType.number,
                    controller: _ipAddressController,
                    decoration: const InputDecoration(
                        filled: true,
                        hintText: "Gib hier die IP-Adresse ein",
                        fillColor: Color(0xfffef7ff)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                        value: _isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value!;
                          });
                        }),
                    const Text("Erstmalige Verbindung?"),
                  ],
                ),
                _isChecked
                    ? Column(
                        children: [
                          const Headline(title: "Benutzername"),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller: _usernameController,
                              decoration: const InputDecoration(
                                  filled: true,
                                  hintText:
                                      "Gib hier den SSH-Benutzernamen ein",
                                  fillColor: Color(0xfffef7ff)),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                _isChecked
                    ? Column(
                        children: [
                          const Headline(title: "Passwort"),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              obscureText: true,
                              controller: _pwController,
                              decoration: const InputDecoration(
                                  filled: true,
                                  hintText:
                                      "Gib hier das Passwort für die SSH-Benutzer ein",
                                  fillColor: Color(0xfffef7ff)),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                const SizedBox(
                  height: 30,
                ),
                _isLoading
                    ? Column(
                        children: [
                          const Text("Stelle Verbindung her..."),
                          LoadingAnimationWidget.staggeredDotsWave(
                            color: Theme.of(context).primaryColor,
                            size: 100,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ))),
                              onPressed: () {
                                setState(() {
                                  _isLoading = false;
                                });
                              },
                              child: const Text("Abbrechen"))
                        ],
                      )
                    : SizedBox(
                        width: 175,
                        height: 40,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ))),
                          onPressed: () async {
                            final newRobot = RobotModel(
                                ipAddress: _ipAddressController.text,
                                name: _nameController.text);
                            connectToNao(newRobot).then((success) {
                              setState(() {
                                _isLoading = false;
                              });
                              if (success == 200) {
                                if (!robotProvider.addRobot(newRobot)) {
                                  success = 409;
                                }
                              }

                              showAlertDialog(success);
                              Navigator.pop(context);
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Expanded(
                                child: Icon(Icons.add),
                              ),
                              Expanded(
                                child: Text("hinzufügen"),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ));
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
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
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
