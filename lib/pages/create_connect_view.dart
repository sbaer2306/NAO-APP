import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nao_app/models/robot_model.dart';
import 'package:nao_app/providers/robot_provider.dart';
import 'package:provider/provider.dart';
import '../ui_elements/nao_background.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../ui_elements/connecting_alert_dialog.dart';

class CreateConnectPage extends StatefulWidget {
  const CreateConnectPage({super.key});

  @override
  State<CreateConnectPage> createState() => _CreateConnectPageState();
}

class _CreateConnectPageState extends State<CreateConnectPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _ipAddressController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _ipAddressController.text = '192.168.171.';
  }

  Future<int> connectToNao(RobotModel robot) async {
    setState(() {
      _isLoading = true;
    });
    return robot.connect();
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(217, 217, 217, 0),
        toolbarHeight: 80,
        title: const Text("Verbinung herstellen",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
      body: Container(
        decoration: connectNAO,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextField(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  controller: _ipAddressController,
                  style: const TextStyle(
                    color: Color(0xff0d2481),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: 'Gib hier die IP-Adresse ein',
                      labelText: 'IP-Adresse',
                      helperText: "Gib hier die IP-Adresse vom NAO ein",
                      labelStyle: const TextStyle(color: Color(0xff0d2481)),
                      fillColor: const Color(0xffd9d9d9)),
                ),
                const SizedBox(
                  height: 20,
                ),
                _isLoading
                    ? Column(
                        children: [
                          const Text("Stelle Verbindung her..."),
                          LoadingAnimationWidget.staggeredDotsWave(
                            color: const Color(0xff0d2481),
                            size: 100,
                          )
                        ],
                      )
                    : ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Color(0xff3bccff))),
                        onPressed: () async {
                          final newRobot =
                              RobotModel(ipAdress: _ipAddressController.text);
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
                        child: const Text(
                          "verbinden",
                        )),
              ]),
        ),
      ),
    );
  }
}
