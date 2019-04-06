import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final Map<String, dynamic> data;

  WeatherCard(this.data);

  @override
  Widget build(BuildContext context) {
    if (data['geo'] == null) {
      return Container();
    }

    Widget renderIcon() {
      if (data['icon'].isNotEmpty) {
        return Image.network(
          'https://ssl.gstatic.com/onebox/weather/256/${data['icon']}.png',
          height: 200,
        );
      }
      return Container();
    }

    return Container(
      width: 300,
      height: 380,
      padding: EdgeInsets.all(7),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(width: 0.9, color: Colors.grey[300])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("${data['city']}, ${data['country']}",
                style: TextStyle(fontSize: 30, color: Colors.grey[800])),
            renderIcon(),
            Text("${data['temp']}°C",
                style: TextStyle(fontSize: 40, color: Colors.grey[800])),
            Text(data['status'],
                style: TextStyle(fontSize: 30, color: Colors.grey[800])),
          ],
        ),
      ),
    );
  }
}
