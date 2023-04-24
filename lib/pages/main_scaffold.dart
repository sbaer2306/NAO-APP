import 'package:flutter/material.dart';

import 'config_view.dart';
import 'connecting_view.dart';
import 'home_view.dart';

class MainScaffold extends StatefulWidget {
  final int initialPage;

  const MainScaffold({Key? key, this.initialPage = 0}) : super(key: key);

  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedPageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectedPageIndex = widget.initialPage;
    _pageController = PageController(initialPage: _selectedPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _setSelectedPage(int i) {
    setState(() {
      _selectedPageIndex = i;
    });
    // _pageController.jumpToPage(i);
    _pageController.animateToPage(
      i,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomeView(
            title: "HomeView",
          ),
          ConnectView(
            title: "ConnectView",
          ),
          ConfigView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.sensors), label: "Connect"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Configure"),
        ],
        currentIndex: _selectedPageIndex,
        onTap: _setSelectedPage,
      ),
    );
  }
}
