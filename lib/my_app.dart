import 'package:flutter/material.dart';
import 'pages/home_page.dart';

class MyAppState extends State<MyApp> {
  int selectedPageIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const Text("foobar"),
    const Text("barbar"),
  ];

  void onTap(int i) {
    setState(() {
      selectedPageIndex = i;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Nao App",
        theme: ThemeData(primaryColor: Colors.purple),
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Nao App"),
            ),
            body: pages.elementAt(selectedPageIndex),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: "Settings"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.lightbulb), label: "Damn"),
              ],
              currentIndex: selectedPageIndex,
              onTap: onTap,
            )));
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}
