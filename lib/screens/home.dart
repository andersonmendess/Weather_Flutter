import 'package:weather/widgets/backgroundContainer.dart';
import 'package:weather/widgets/weatherCard.dart';
import 'package:weather/blocs/weather-bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:weather/screens/search.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TimeOfDay now = TimeOfDay.now();

    final WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);

    weatherBloc.main();

    return Stack(children: <Widget>[
      StreamBuilder(
        stream: weatherBloc.getDayOrNight,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BackgroudContainer(snapshot.data);
          } else {
            return BackgroudContainer(now.period.index == 0 ? 'D' : "N");
          }
        },
      ),
      CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.transparent,
            brightness: Brightness.dark,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.refresh, color: Theme.of(context).accentColor),
              onPressed: () {
                weatherBloc.main();
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Weather",
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              centerTitle: true,
            ),
            actions: <Widget>[
              IconButton(
                  icon:
                      Icon(Icons.search, color: Theme.of(context).accentColor),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Search()));
                  }),
            ],
          ),
          SliverToBoxAdapter(
            child: StreamBuilder(
              stream: weatherBloc.getWeather,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return WeatherCard(json.decode(snapshot.data));
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      )
    ]);
  }
}
