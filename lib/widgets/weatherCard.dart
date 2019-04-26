import 'package:flutter/material.dart';
import 'package:weather/models/weather.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  WeatherCard(this.weather);

  final Map<String, List<int>> themes = {
    'D': [240, 235, 235, 235],
    'N': [10, 15, 15, 40]
  };

  @override
  Widget build(BuildContext context) {
    final List<int> argb = themes[weather.dyNght];
    final Color textColor = argb[0] == 10 ? Colors.grey[100] : Colors.black;

    Widget renderIcon() {
      if (weather.icon.isNotEmpty) {
        return Padding(
          padding: EdgeInsets.all(19),
          child: Image.asset(
            "icons/${weather.icon}.png",
            height: 190,
          ),
        );
      }
      return Container();
    }

    return Container(
      height: 420,
      padding: EdgeInsets.all(15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Color.fromARGB(argb[0], argb[1], argb[2], argb[3]),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("${weather.city}, ${weather.country}",
                  style: TextStyle(color: textColor, fontSize: 30)),
              renderIcon(),
              Text("${weather.temp}°C",
                  style: TextStyle(color: textColor, fontSize: 36)),
              Text(weather.status,
                  style: TextStyle(color: textColor, fontSize: 30)),
            ],
          ),
        ),
      ),
    );
  }
}
