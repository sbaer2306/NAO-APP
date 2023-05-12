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

  bool _isLoading = false;

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
      return robot.connect();
    }

    //TODO Einbetten in MainScaffold
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color(0xfffef7ff),
          centerTitle: true,
          toolbarHeight: 80,
          title: const Text("Verbindung zum NAO herstellen",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              )),
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
                const Headline(title: "Name"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
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
                    keyboardType: TextInputType.number,
                    controller: _ipAddressController,
                    decoration: const InputDecoration(
                        filled: true,
                        hintText: "Gib hier die IP-Adresse ein",
                        fillColor: Color(0xfffef7ff)),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                _isLoading
                    ? Column(
                        children: [
                          const Text("Stelle Verbindung her..."),
                          LoadingAnimationWidget.staggeredDotsWave(
                            color: Theme.of(context).primaryColor,
                            size: 100,
                          )
                        ],
                      )
                    : SizedBox(
                        width: 140,
                        height: 40,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(RoundedRectangleBorder(
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
                                showAlertDialog(success);
                                if (success == 200) {
                                  robotProvider.addRobot(newRobot);
                                  //Navigator.pop(context);
                                }
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Icon(Icons.add),
                                Text("verbinden", style: TextStyle(fontSize: 17))
                              ],
                            )),
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
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
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
