import 'package:flutter/material.dart';
import 'package:weather/widgets/weatherCard.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:weather/screens/search.dart';

import 'package:weather/widgets/backgroundContainer.dart';
import 'dart:convert';

import 'package:weather/bloc/home-bloc.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);

    return Stack(children: <Widget>[
      BackgroudContainer('day'),
      CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.transparent,
            brightness: Brightness.dark,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.refresh, color: Theme.of(context).accentColor),
              onPressed: () {},
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
                  }),
            ],
          ),
          SliverToBoxAdapter(
            child: StreamBuilder(
              stream: homeBloc.getWeather,
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