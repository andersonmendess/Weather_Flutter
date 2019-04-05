import 'package:flutter/material.dart';
import 'package:weather/widgets/weatherCard.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather"),
        elevation: 0.3,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 12),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:BorderRadius.circular(8.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Please enter your location',
                  hintStyle: TextStyle(color: Colors.grey[600])
                ),
              ),
            ),
            WeatherCard("Bahia", "Brasil", "rain_s_cloudy", "33"),
          ]),
    ),
    );
  }
}
