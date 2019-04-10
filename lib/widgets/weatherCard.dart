import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final Map<String, dynamic> data;

  WeatherCard(this.data);

  @override
  Widget build(BuildContext context) {

    Widget renderIcon() {
      if (data['icon'].isNotEmpty) {
        return Padding(
          padding: EdgeInsets.all(19),
          child: Image.asset(
            'icons/clear-day.png',
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
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("${data['city']}, ${data['country']}", style: Theme.of(context).textTheme.title),
              renderIcon(),
              Text("${data['temp']}°C", style: Theme.of(context).textTheme.title),
              Text(data['status'], style: Theme.of(context).textTheme.title),
            ],
          ),
        ),
      ),
    );
  }
}
