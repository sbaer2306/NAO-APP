import 'package:flutter/material.dart';
import 'package:nao_app/pages/movement_view.dart';
import 'package:nao_app/pages/speaker_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.title});

  final String title;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void _toggleNaoList() {}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  onPressed: _toggleNaoList,
                  icon: const Badge(
                    label: Text('6'),
                    child: Icon(Icons.menu),
                  ),
                ),
              ],
              title: const Text("Home"),
              centerTitle: true,
              bottom: const TabBar(tabs: [
                Tab(text: "Movement"),
                Tab(text: "Speaking"),
              ]),
            ),
            body: const TabBarView(
              children: [
                MovementView(),
                SpeakerView(),
              ],
            )));
  }
}
