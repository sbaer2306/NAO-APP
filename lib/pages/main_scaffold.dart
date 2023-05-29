import 'package:flutter/material.dart';

import 'config_view.dart';
import 'connecting_view.dart';
import 'home_view.dart';

class MainScaffold extends StatefulWidget {
  final int initialPage;

  const MainScaffold({Key? key, this.initialPage = 0}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedPageIndex = 0;

  List<Widget> pages = [
    Navigator(
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (context) => const HomeView()),
    ),
    Navigator(
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (context) => const ConnectView()),
    ),
    Navigator(
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (context) => const ConfigView()),
    )
  ];

  @override
  void initState() {
    super.initState();
    _selectedPageIndex = widget.initialPage;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _setSelectedPage(int i) {
    setState(() {
      _selectedPageIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedPageIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepPurple[50],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.sensors), label: "Verbinden"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Konfigurieren"),
        ],
        currentIndex: _selectedPageIndex,
        onTap: _setSelectedPage,
      ),
    );
  }
}
