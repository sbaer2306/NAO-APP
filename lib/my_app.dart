import 'package:flutter/material.dart';
import 'pages/connecting_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NAO-App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const SafeArea(child: MyHomePage(title: "NAO-App")),
    );
  }
}
