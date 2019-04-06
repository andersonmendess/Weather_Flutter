import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {

  final String city;
  final String location;
  final String icon;
  final String temp;

  WeatherCard(this.city, this.location, this.icon, this.temp);

  @override
  Widget build(BuildContext context) {

    if(temp == null){
      return Container();
    }

    Widget renderIcon(){

      if(icon.isNotEmpty){
        return Image.network(
          'https://ssl.gstatic.com/onebox/weather/256/$icon.png',
          height: 200,
        );
      }
      return Container();
    }

    return Container(
          width: 300,
          height: 340,
          padding: EdgeInsets.all(5),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: BorderSide(width: 0.9, color: Colors.grey[300])),
            margin: EdgeInsets.only(bottom: 15, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("$city, $location",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w400)),
                renderIcon(),
                Text("$temp°C",
                    style:
                        TextStyle(fontSize: 39, fontWeight: FontWeight.w400)),
              ],
            ),
          ),
        );
  }
}
