import 'package:flutter/material.dart';

class BackgroudContainer extends StatelessWidget {

  final String theme;

  BackgroudContainer(this.theme);

  final Map<String, List<Color>> themes = {
    'D': [
      Color.fromARGB(255, 31, 170, 250),
      Color.fromARGB(255, 170, 235, 253),
    ],
    'N': [
      Color.fromARGB(255, 15, 35, 63),
      Color.fromARGB(255, 15, 15, 25),
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: themes[theme],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
