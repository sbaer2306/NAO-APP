import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/robot_provider.dart';
import '../ui_elements/info_card.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

class CameraView extends StatefulWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  CameraViewState createState() => CameraViewState();
}

class CameraViewState extends State<CameraView> {
  bool isPressed = false;

  void toggleView() {
    setState(() {
      isPressed = !isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    final robotProvider = Provider.of<RobotProvider>(context, listen: false);
    final robots = robotProvider.activeItems;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const InfoCard(
          title: "Schau durch die Augen des NAO's",
          description:
              "Wähle einen verbundenen NAO und aktiviere seine Kamera.",
        ),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                  child: (isPressed && robots.isNotEmpty)
                      ? GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      (robots.length / 2).round() > 0
                                          ? (robots.length / 2).round()
                                          : 1),
                          itemCount: robots.length,
                          itemBuilder: (context, index) {
                            return Mjpeg(
                              stream: robots[index].getVideoStream(),
                              isLive: true,
                            );
                          },
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.no_photography, size: 100),
                            const SizedBox(
                              height: 20,
                            ),
                            robots.isNotEmpty
                                ? const Text("Die Kamera ist ausgeschaltet")
                                : const Text("Wähle deine NAO's aus"),
                          ],
                        ))),
        ),
        SizedBox(
          width: double.infinity,
          child: Container(
            padding: const EdgeInsets.only(left: 20.0),
            child: const Text(
              "CONTROLS",
              textAlign: TextAlign.start,
              style: TextStyle(color: Color.fromARGB(255, 141, 132, 165)),
            ),
          ),
        ),
        Wrap(
          spacing: 8.0,
          alignment: WrapAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple[50],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: IconButton(
                onPressed: () {
                  toggleView();
                },
                icon: const Icon(Icons.power_settings_new),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
