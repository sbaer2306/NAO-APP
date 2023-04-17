import 'package:flutter/material.dart';
import 'package:nao_app/pages/connecting_view.dart';
import 'pages/home_page.dart';
import 'pages/start_view.dart';

class MyAppState extends State<MyApp> {
  int selectedPageIndex = 0;

  final List<Widget> pages = [
    const Center(child: StartView(title: "Startview")),
    const Center(child: ConnectView(title: "NAO-App")),
    const Center(child: ConfigView()),
  ];

  void setSelectedPage(int i) {
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
        debugShowCheckedModeBanner: false,
        title: 'NAO-App',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  title: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("NAO "),
                      Icon(Icons.smart_toy_outlined),
                      Text(" APP")
                    ],
                  )),
                ),
                body: pages.elementAt(selectedPageIndex),
                bottomNavigationBar: BottomNavigationBar(
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: "Home"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.sensors), label: "Connect"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings), label: "Configure"),
                  ],
                  currentIndex: selectedPageIndex,
                  onTap: setSelectedPage,
                ))));
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}
