import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/robot_provider.dart';
import '../ui_elements/info_card.dart';

class CameraView extends StatefulWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  CameraViewState createState() => CameraViewState();
}

class CameraViewState extends State<CameraView> {
  List<String> imageUrls = []; //Storing images send from Nao here.
  @override
  Widget build(BuildContext context) {
    final robotProvider = Provider.of<RobotProvider>(context, listen: false);

    Future<void> activateCamera() async {
      //f.e. fetchedImageUrls = await
      try {
        //f.e. List<String> fetchedImageUrls = await robotProvider.items[0].activateCamera();
        setState(() {
          //imageUrls = fetchedImageUrls;
        });
      } catch (error) {
        print('Error occured: $error');
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const InfoCard(
          title: "Schau durch die Augen des NAO's",
          description:
              "Wähle einen verbundenen NAO und aktiviere seine Kamera.",
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                'Camera Footage',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
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
            IconButton(
              onPressed: activateCamera,
              icon: const Icon(Icons.camera),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
