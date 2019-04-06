import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:weather/screens/home.dart';
import 'package:weather/bloc/weatherController.dart';

void main() {
  runApp(MaterialApp(
    title: "Weather",
    home: BlocProvider<WeatherController>(
        child: Home(),
      bloc: WeatherController(),
    ),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'GoogleSans',
      primaryColor: Colors.white,
        hintColor: Colors.grey[300]
    ),
  ));
}
