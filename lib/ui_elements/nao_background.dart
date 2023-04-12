import 'package:flutter/material.dart';

BoxDecoration connectNAO = BoxDecoration(
  image: DecorationImage(
    image: const AssetImage("assets/background_images/connecting_page.png"),
    fit: BoxFit.cover,
    colorFilter:
        ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
  ),
);

//Overkill evtl. nicht nötig bzw. funktioniet nicht
/* class NaoBackground extends StatelessWidget {
  const NaoBackground({super.key, required this.background});

  final String background;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(background),
        fit: BoxFit.cover,
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
      ),
    ));
  }
} */