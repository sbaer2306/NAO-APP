import 'package:flutter/material.dart';

class ConfigView extends StatelessWidget {
  const ConfigView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void promptDialog() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Dialog Title"),
              content: const Text("Dialog Content"),
              actions: [
                TextButton(
                    child: const Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Close"))
              ],
            );
          });
    }

    return Center(
        child: Card(
            child:
                ButtonBar(alignment: MainAxisAlignment.spaceEvenly, children: [
      ElevatedButton(
        onPressed: promptDialog,
        child: Row(
          children: const [
            Icon(Icons.home),
            Text("Home"),
          ],
        ),
      ),
      const Text("World"),
      const Text("!")
    ])));
  }
}
