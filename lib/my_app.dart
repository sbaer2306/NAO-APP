import 'package:flutter/material.dart';
import 'package:nao_app/pages/connecting_view.dart';
import 'package:nao_app/pages/main_scaffold.dart';
import 'pages/config_view.dart';
import 'pages/home_view.dart';

class MyAppState extends State<MyApp> {
  int selectedPageIndex = 0;

  final List<Widget> pages = [
    const Center(child: HomeView(title: "Startview")),
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
        primarySwatch: Colors.indigo,
      ),
      home: const SafeArea(
        child: MainScaffold(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}
