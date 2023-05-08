import 'package:flutter/material.dart';
import 'package:nao_app/pages/main_scaffold.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NAO-App',
      theme: ThemeData(
        primarySwatch:
            Colors.deepPurple, //shade 50 cannot be used due to wrong Type
      ),
      home: const SafeArea(
        child: MainScaffold(),
      ),
    );
  }
}
